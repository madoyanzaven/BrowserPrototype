//
//  HistoryModelFactory.swift
//  BrowserPrototypeTests
//
//  Created by Zaven Madoyan on 15.05.23.
//

import Foundation

@testable import BrowserPrototype

final class HistoryModelFactory {
    static func create(url: String,
                       date: Date = Date()
    ) -> BrowserPrototype.HistoryModel {
        return HistoryModel(url: url,
                            date: date)
    }
}
