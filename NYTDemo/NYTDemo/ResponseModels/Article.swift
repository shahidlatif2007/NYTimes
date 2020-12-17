//
//  Article.swift
//  NYTDemo
//
//  Created by Shahid Latif on 17/12/2020.
//  Copyright © 2020 Shahid Latif. All rights reserved.
//

import Foundation

struct ArticleResponse: Decodable {
    let status: String
    let copyright: String
    let numberOfResults: Int
    let results: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status, copyright
        case results
        case numberOfResults = "num_results"
    }
}

struct Article: Decodable {
    let id: Int
    let title: String
    let byline: String
    let publishDate: String
    let adxKeywords: String
    let media: [Media]
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, byline
        case media, url
        case adxKeywords = "adx_keywords"
        case publishDate = "published_date"
    }
    
    func imageURL() -> String? {
        var imageURL: String? = nil
        if media.count > 0 {
            let imageMetaData = media[media.count - 1]
            imageURL = imageMetaData.imageURL()
        }
        return imageURL
    }
    
    func caption() -> String? {
        var caption: String? = nil
        if media.count > 0 {
            let imageMetaData = media[media.count - 1]
            caption = imageMetaData.caption
            if caption == "" {
                caption = imageMetaData.copyright
            }
        }
        return caption
    }
}

struct Media: Decodable {
    let copyright: String
    let caption: String
    let mediaMetaData: [MediaMetaData]
    
    enum CodingKeys: String, CodingKey {
        case copyright
        case caption
        case mediaMetaData = "media-metadata"
    }
    
    fileprivate func imageURL() ->  String? {
        var imgURL: String? = nil
        if mediaMetaData.count > 0 {
            let metaData = mediaMetaData[mediaMetaData.count - 1]
            imgURL = metaData.url
        }
        return imgURL
    }
}

struct MediaMetaData: Decodable {
    let url: String
    let width: Int
    let height: Int
}
