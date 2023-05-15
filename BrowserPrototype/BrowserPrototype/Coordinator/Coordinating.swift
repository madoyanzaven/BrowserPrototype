//
//  Coordinating.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import UIKit

protocol Coordinating {
    var navigationController: UINavigationController { get set }
    
    func start()
}
