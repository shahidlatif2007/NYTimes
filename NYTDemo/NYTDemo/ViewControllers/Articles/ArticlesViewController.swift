//
//  ArticlesViewController.swift
//  NYTDemo
//
//  Created by Shahid Latif on 17/12/2020.
//  Copyright © 2020 Shahid Latif. All rights reserved.
//

import UIKit

class ArticlesViewController: UITableViewController {
    let activity: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    let articleViewModel = ArticleViewModel()
    var detailViewController: ArticleDetailViewController? = nil
}

// MARK: View Controller Life Cycle

extension ArticlesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        self.tableView.refreshControl = UIRefreshControl()
        
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        articleViewModel.articles.bind { (articles) in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                if articles.count > 0 {
                    self?.detailViewController?.article = articles[0]
                }
                self?.activity.stopAnimating()
                self?.refreshControl?.endRefreshing()
            }
        }
        articleViewModel.apiError?.bind(listener: { (error) in
            if error.errorMessage != nil && error.title != nil {
                self.showErrorAlert(error: error)
                self.refreshControl?.endRefreshing()
            }
        })
        view.addSubview(activity)
        activity.tintColor = .black
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor)
        ])
        
        fetchArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
}

// MARK: UITableView delegate and Data source
extension ArticlesViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Showing the filter by in table view section
        return "Filter By " + articleViewModel.filterBy()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  articleViewModel.articles.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        let article = articleViewModel.articles.value[indexPath.row]
        cell.article = article
        return cell
    }
}

// MARK: Segue

extension ArticlesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! ArticleDetailViewController
                controller.article = articleViewModel.articles.value[indexPath.row]
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }
}

extension ArticlesViewController {
    func fetchArticles() {
        activity.startAnimating()
        articleViewModel.fetchArticles()
    }
    
    func setupUI() {
        let addButton = UIBarButtonItem(image: UIImage(named: "filter"), style: .done, target: self, action: #selector(showFilterOptions(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ArticleDetailViewController
        }
        
    }
    
    func showErrorAlert(error: NetworkError) {
        let alert = UIAlertController(title: error.title, message: error.errorMessage, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.activity.stopAnimating()
        }
        alert.addAction(cancelAction)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (_) in
            self.fetchArticles()
        }
        
        alert.addAction(retryAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func refresh(sender:AnyObject) {
        fetchArticles()
    }
}





extension ArticlesViewController: UIActionSheetDelegate {
    @objc func showFilterOptions(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Choose Filter", message: "Article will be shown based on following filter. Please choose one.", preferredStyle: .alert)
        
        for item in articleViewModel.timePeriod {
            let action = UIAlertAction(title: item.name,
                                       style: UIAlertAction.Style.default,
                                       handler: {[unowned self] (action: UIAlertAction!) in
                                        
                                        if let title = action.title {
                                            let period = TimePeriod.init(rawValue: title)
                                            if self.articleViewModel.shouldSendRequest(targetTimePeriod: period) {
                                                self.articleViewModel.setTimePeriod(timePeriod: period)
                                                self.fetchArticles()
                                            }
                                        }
            })
            
            alertController.addAction(action)
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
}

