//
//  ViewControllerProvider.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import Foundation

enum ViewControllerProvider {
    static var home: HomeViewController {
        return HomeViewController()
    }
    
    static var history: HistoryViewController {
        return HistoryViewController()
    }
}
