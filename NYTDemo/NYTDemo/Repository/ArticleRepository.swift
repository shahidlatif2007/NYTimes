//
//  ArticleRepository.swift
//  NYTDemo
//
//  Created by Shahid Latif on 17/12/2020.
//  Copyright © 2020 Shahid Latif. All rights reserved.
//

import Foundation

let NYT_API_KEY = "FoFWxV0ESSQU3ehb30XrRFGHGB0jYas0"

enum TimePeriod : String {
    case Day = "1"
    case Week = "7"
    case Month = "30"
    
    static let names = [Day, Week, Month]
    
    var name: String {
        switch self {
        case .Day:
            return "Day"
        case .Week:
            return "Week"
        case .Month:
            return "Month"
        }
    }
    
    init(rawValue: String){
        switch rawValue {
        case TimePeriod.Day.name:
            self = .Day
        case TimePeriod.Week.name:
            self = .Week
        case TimePeriod.Month.name:
            self = .Month
        default:
            self = .Day
        }
    }
    
}

class ArticleRepository: NYTServiceAPI {
    
    var timePeriod = TimePeriod.Day
    override var path: String! {
        return "/mostpopular/v2/mostviewed/all-sections/\(timePeriod.rawValue).json?api-key=\(apiKey)"
    }
    
    override var httpMethod: HttpMethod! {
        return .get
    }
    
    func fetchArticles(complete :@escaping (ArticleResponse) -> Void, failure:@escaping onFailure) {
        self.network.request(self.httpRequest, success: { (response: ArticleResponse) in
            complete(response)
        }) { (error: NetworkError) in
            failure(error)
        }
    }
}
