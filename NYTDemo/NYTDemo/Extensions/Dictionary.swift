//
//  Dictionary.swift
//  NYTDemo
//
//  Created by Shahid Latif on 17/12/2020.
//  Copyright © 2020 Shahid Latif. All rights reserved.
//

import Foundation

extension Dictionary {
    
    var jsonString:String {
        var jsonString : String = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            jsonString = String(data: jsonData, encoding: String.Encoding.utf8)! as String
        } catch {
            print(error.localizedDescription)
        }
        return jsonString
    }
    
    
    var queryString: String {
        var finalString: String = ""
        for (key,value) in self {
            finalString +=  "\(key)=\(value)&"
        }
        finalString = String(finalString.dropLast())
        if finalString == "=" {
            finalString = ""
        }
        return finalString
    }
}
