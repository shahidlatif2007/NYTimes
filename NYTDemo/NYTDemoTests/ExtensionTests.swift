//
//  ExtensionTests.swift
//  NYTDemoTests
//
//  Created by Shahid Latif on 17/12/2020.
//  Copyright © 2020 Shahid Latif. All rights reserved.
//

import XCTest
@testable import NYTDemo

class ExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLabel() {
        XCTAssertNotNil(UILabel.imageWithText(image: UIImage(named: "calendar")!, text: "Test "))
    }
    
    
    func testDictionary() {
        var dictionary = [String: String]()
        XCTAssertTrue(dictionary.jsonString == "{\n\n}")
        
        dictionary["value"] = "Test"
        dictionary["value1"] = "Test2"
        
        XCTAssertTrue(dictionary.jsonString != "")
        
        let query = dictionary.queryString
        XCTAssertTrue(query == "value=Test&value1=Test2")
    }

}
