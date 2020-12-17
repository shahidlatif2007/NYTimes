//
//  NetworkErrorTests.swift
//  NYTDemoTests
//
//  Created by Shahid Latif on 17/12/2020.
//  Copyright © 2020 Shahid Latif. All rights reserved.
//

import XCTest
@testable import NYTDemo

class NetworkErrorTests: XCTestCase {
    
    var error:NetworkError!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        error = NetworkError()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testResourceNotFound() {
        let title = "No Data"
        let errorMessage = "Resource Not found"
        
        
        error.statusCode = 404
        
        XCTAssertTrue(error.title == title && errorMessage == error.errorMessage)
    }
    
    func testCouldNotConnectInternet() {
        let title = "Error"
        let errorMessage = "Cannot Connect To Internet"
        
        error.statusCode = Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue)
        
        XCTAssertTrue(error.title == title && errorMessage == error.errorMessage)
    }
    
    func testUnableToAccessServer() {
        let title = "Error"
        let errorMessage = "Unable To Access Server"
        
        error.statusCode = Int(CFNetworkErrors.cfurlErrorCannotConnectToHost.rawValue)
        
        XCTAssertTrue(error.title == title && errorMessage == error.errorMessage)
    }
    
    func testDefaultErrorCodeHost() {
        let title = "Error"
        let errorMessage = "Something went wrong. Please try again later."
        
        error.statusCode = 300
        
        XCTAssertTrue(error.title == title && errorMessage == error.errorMessage)
    }
}
