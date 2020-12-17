
//
//  NetworkConfig.swift
//  NYTDemo
//
//  Created by Shahid Latif on 17/12/2020.
//  Copyright © 2020 Shahid Latif. All rights reserved.
//

import Foundation

let kCharsetUTF8Value = "application/x-www-form-urlencoded"
let kJSONValue = "application/json"
let kContentTypeHeader  = "Content-Type"
let kRequestParam = "param"

protocol EndPointType {
    var baseUrl : String! {get}
    var path : String! {get}
    var httpMethod : HttpMethod! {get}
    var httpRequest : URLRequest! {get}
    var paramters : [String : Any]! {get}
}




final class NetworkConfiguration {
    static func baseURL () -> String? {
        // Check if URL is added in plist file.
        assert(Bundle.main.infoDictionary!["BASE_URL"] != nil)
        return Bundle.main.infoDictionary?["BASE_URL"] as? String
    }
}
