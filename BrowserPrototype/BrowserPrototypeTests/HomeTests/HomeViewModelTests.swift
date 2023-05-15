//
//  HomeViewModelTests.swift
//  BrowserPrototypeTests
//
//  Created by Zaven Madoyan on 15.05.23.
//

import XCTest

@testable import BrowserPrototype

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var service: MockHistoryListService!
    
    override func setUp() {
        super.setUp()
        
        service = MockHistoryListService()
        let inputs = HomeInputs(historyService: service)
        viewModel = HomeViewModel(inputs: inputs)
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
        service = nil
    }
    
    func testSaveData() {
        XCTAssertEqual(service.savedItemCount, 1, "savedItemCount default value is 1, savedItemCount is \(service.savedItemCount)")
        
        viewModel.saveHistory(with: HistoryModelFactory.create(url: "", date: Date()))
        
        XCTAssertEqual(service.savedItemCount, 2, "savedItemCountt is  \(service.savedItemCount), expected value: 2")
    }
}
