//
//  MockHistoryListService.swift
//  BrowserPrototypeTests
//
//  Created by Zaven Madoyan on 15.05.23.
//

import Foundation

@testable import BrowserPrototype

final class MockHistoryListService: BaseMockService, HistoryListServicing {
    func save(history: BrowserPrototype.HistoryModel) {
        savedItemCount += 1
    }
    
    func getAllHistory() -> [BrowserPrototype.HistoryModel] {
        fetchMethodCallCount += 1
        showEmptyView = false
        
        return HistoryListFactory.create(count: 1)
    }
    
    func deleteHistory() {
        savedItemCount = 0
    }
}
