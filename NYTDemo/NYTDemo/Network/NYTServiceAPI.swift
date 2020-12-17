//
//  NYTServiceAPI.swift
//  NYTDemo
//
//  Created by Shahid Latif on 17/12/2020.
//  Copyright © 2020 Shahid Latif. All rights reserved.
//

import Foundation

class NYTServiceAPI: WebServiceApi {
    
    override var baseUrl: String! {
        
        NetworkConfiguration.baseURL()
    }
    
}
