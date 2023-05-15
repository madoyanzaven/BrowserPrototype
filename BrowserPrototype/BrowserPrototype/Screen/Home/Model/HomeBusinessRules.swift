//
//  HomeBusinessRules.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import Foundation

protocol HomeBusinessRules {
    func isNetworkAvailable() -> Bool
}

extension HomeBusinessRules {
    func isNetworkAvailable() -> Bool {
        return ReachabilityManager().isConnectedToNetwork()
    }
}
