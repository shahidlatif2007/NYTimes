//
//  Box.swift
//  NYTDemoTests
//
//  Created by Shahid Latif on 17/12/2020.
//  Copyright © 2020 Shahid Latif. All rights reserved.
//

import XCTest
@testable import NYTDemo

class BoxTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBox() {
        let box = Box(20)
        box.bind { (value) in
            XCTAssertEqual(value, 30)
        }
        box.value = 30
    }
    
}


