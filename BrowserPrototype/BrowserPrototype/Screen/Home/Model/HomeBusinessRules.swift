//
//  HomeBusinessRules.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import UIKit

protocol HomeBusinessRules {
    func isNetworkAvailable() -> Bool
    func isValidURL(_ urlString: String) -> Bool
}

extension HomeBusinessRules {
    func isNetworkAvailable() -> Bool {
        return ReachabilityManager().isConnectedToNetwork()
    }
    
    func isValidURL(_ urlString: String) -> Bool {
        guard let url = URL(string: urlString) else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
}
