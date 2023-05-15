//
//  HistoryListFactory.swift
//  BrowserPrototypeTests
//
//  Created by Zaven Madoyan on 15.05.23.
//

import Foundation
@testable import BrowserPrototype

final class HistoryListFactory {
    static func create(count: Int) -> [HistoryModel] {
        let history = HistoryModelFactory.create(url: "https://www.google.com", date: Date())
        
        return Array(repeating: history, count: count)
    }
}
