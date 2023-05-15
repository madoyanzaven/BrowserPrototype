//
//  HomeBusinessRulesTests.swift
//  BrowserPrototypeTests
//
//  Created by Zaven Madoyan on 15.05.23.
//

import XCTest
@testable import BrowserPrototype

final class HomeBusinessRulesTests: XCTestCase {
    private struct MockedHomeBusinessRules: HomeBusinessRules {}
    private let homeBusinessRulesTests = MockedHomeBusinessRules()
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    func testIsNetworkAvailable() {
        let actualResult = homeBusinessRulesTests.isNetworkAvailable()
        
        XCTAssertTrue(actualResult)
    }
    
    func testValidURL() {
        let validUrlString = "https://www.apple.com"
        let actualResult = homeBusinessRulesTests.isValidURL(validUrlString)
        
        XCTAssertTrue(actualResult)
    }
    
    func testNotValidURL() {
        let notValidUrlString = "notValidUrlString.com"
        let actualResult = homeBusinessRulesTests.isValidURL(notValidUrlString)
        
        XCTAssertFalse(actualResult)
    }
    
    func testFormatURL() {
        let inputUrlString = "apple.com"
        let actualResult = homeBusinessRulesTests.formatURLString(inputUrlString)
        let expectedResult = "https://www.apple.com"
        XCTAssertEqual(expectedResult, actualResult)
    }
}
