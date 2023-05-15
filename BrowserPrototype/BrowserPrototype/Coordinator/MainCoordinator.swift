//
//  MainCoordinator.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import Combine
import UIKit

final class MainCoordinator: Coordinating {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewControllerProvider.home
        
        vc.viewModel.setupCoordinator(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushToHistory(loadWebViewSubject: PassthroughSubject<String, Never>) {
        let history = ViewControllerProvider.history

        navigationController.pushViewController(history, animated: true)
    }
    
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Something went wrong.",
                                      message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: nil))
        
        navigationController.present(alert, animated: true)
    }
}
