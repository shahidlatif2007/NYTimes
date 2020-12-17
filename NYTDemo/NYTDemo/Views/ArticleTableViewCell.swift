//
//  ArticleTableViewCell.swift
//  NYTDemo
//
//  Created by Shahid Latif on 17/12/2020.
//  Copyright © 2020 Shahid Latif. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var articleBy: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    
    var article:Article! {
        didSet {
            title.text = article.title
            articleBy.text = article.byline
            publishDate.attributedText = UILabel.imageWithText(image: #imageLiteral(resourceName: "calendar"), text: article.publishDate)
            circleImageView.loadImageWithURLString(urlString: article.imageURL() ?? "") {
                
            }
            self.backgroundColor = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        }
    }
}

extension ArticleTableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        circleImageView.layer.cornerRadius = circleImageView.frame.size.height / 2.0
        circleImageView.layer.masksToBounds = true
    }
}
