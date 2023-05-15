//
//  HistoryViewModelTests.swift
//  BrowserPrototypeTests
//
//  Created by Zaven Madoyan on 15.05.23.
//

import XCTest

@testable import BrowserPrototype

class HistoryViewModelTests: XCTestCase {
    var viewModel: HistoryViewModel!
    var service: MockHistoryListService!
    
    override func setUp() {
        super.setUp()
        
        service = MockHistoryListService()
        let inputs = HistoryInputs(historyService: service)
        viewModel = HistoryViewModel(inputs: inputs)
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
        service = nil
    }
    
    func testFetchData() {
        XCTAssertEqual(service.fetchMethodCallCount, 0, "fetchMethodCallCount default value is 0, fetch count is \(service.fetchMethodCallCount)")
        
        viewModel.getHistory()
        
        XCTAssertEqual(service.fetchMethodCallCount, 1, "fetchMethodCallCount is  \(service.fetchMethodCallCount), expected value: 1")
    }
    
    func testRemoveData() {
        XCTAssertEqual(service.savedItemCount, 1, "savedItemCount default value is 1, savedItemCount is \(service.savedItemCount)")
        
        viewModel.deleteHistory()
        
        XCTAssertEqual(service.savedItemCount, 0, "savedItemCountt is  \(service.savedItemCount), expected value: 0")
    }
    
    func testEmptyView() {
        let actualResult = service.showEmptyView
        XCTAssertTrue(actualResult)
    }
    
    func testNotEmptyView() {
        viewModel.getHistory()
        let actualResult = service.showEmptyView
        XCTAssertFalse(actualResult)
    }
}
