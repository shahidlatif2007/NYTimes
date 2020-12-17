//
//  ArticleDetailViewController.swift
//  NYTDemo
//
//  Created by Shahid Latif on 17/12/2020.
//  Copyright © 2020 Shahid Latif. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController  {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageCaption: UILabel!
    @IBOutlet weak var articleDesp: UILabel!
    @IBOutlet weak var publishedDate: UILabel!
    @IBOutlet weak var imageDownloadActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var selectColumnView: UIView!
    
    var article: Article? {
        didSet {
            configureView()
        }
    }
    

}

extension ArticleDetailViewController {
    func configureView() {
        // Update the user interface for the detail item.
        var shouldShowSelectColumView = false
        if let detail = article {
            if let imageView = imageView {
                if let imgURL = detail.imageURL() {
                    DispatchQueue.main.async {
                        self.imageDownloadActivityIndicator.startAnimating()
                    }
                    
                    imageView.loadImageWithURLString(urlString:imgURL) {
                        DispatchQueue.main.async {
                            self.imageDownloadActivityIndicator.stopAnimating()
                        }
                    }
                }else {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(named: "default")!
                    }
                }
            }
            
            if let imageCaption = imageCaption {
                 imageCaption.text = detail.caption()
             }
            
            if let articleDesp = articleDesp {
                articleDesp.text = detail.adxKeywords
            }
            
            if let publishedDate = publishedDate {
                publishedDate.text = detail.publishDate
            }
            shouldShowSelectColumView = true
        }
        DispatchQueue.main.async { [weak self] in
            self?.selectColumnView.isHidden = shouldShowSelectColumView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}
