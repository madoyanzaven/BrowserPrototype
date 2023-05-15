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
    func formatURLString(_ urlString: String) -> String
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
    
    func formatURLString(_ urlString: String) -> String {
        var formattedURL = urlString
        if !(formattedURL.hasPrefix("http://") || formattedURL.hasPrefix("https://")) {
            if !formattedURL.hasPrefix("www.") {
                formattedURL = "https://www." + formattedURL
            } else {
                formattedURL = "https://" + formattedURL
            }
        }
        
        return formattedURL
    }
}
