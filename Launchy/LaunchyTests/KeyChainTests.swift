//
//  KeyChainTests.swift
//  Launchy
//
//  Created by Manchung.Ho on 11/8/14.
//  Copyright (c) 2014 net.mincong. All rights reserved.
//

import UIKit
import XCTest
import Launchy

class KeyChainTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case."
        let token1 = "xxoo,something";
        let userAccount1 = "testuser";
        KeychainService.saveToken(token1, userAccount: userAccount1);
        let ret1 = KeychainService.loadToken(userAccount1)
        XCTAssert(ret1 == token1);
    }
    
    func testEmptytoken() {
        // This is an example of a functional test case."
        let token2 = "";
        let userAccount2 = "testuser";
        KeychainService.saveToken(token2, userAccount: userAccount2);
        let ret2 = KeychainService.loadToken(userAccount2)
        XCTAssert(ret2 == token2);
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
