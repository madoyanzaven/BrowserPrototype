//
//  Collection+index.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import Foundation

extension Collection {
    subscript (safe index: Self.Index) -> Element? {
        guard indices.contains(index) else { return nil }

        return self[index]
    }
}
