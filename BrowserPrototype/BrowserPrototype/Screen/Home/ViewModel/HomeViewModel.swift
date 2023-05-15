//
//  HomeViewModel.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import Combine
import UIKit

final class HomeViewModel: HomeBusinessRules {
    private weak var coordinator : MainCoordinator!
    private let loadWebViewSubject = PassthroughSubject<String, Never>()
    let inputs: HomeInputs
    var navigationTitle: String = "Home"
    var loadWebViewPublisher: AnyPublisher<String, Never> {
        return loadWebViewSubject.eraseToAnyPublisher()
    }
    
    init(inputs: HomeInputs) {
        self.inputs = inputs
    }
    
    func setupCoordinator(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    func hasAvailableNetwork() -> Bool {
        if isNetworkAvailable() {
            return true
        } else {
            coordinator.showAlert(with: "There are issues with your network connectivity.\nPlease try again.")
            return false
        }
    }
    
    func navigateToHistory() {
        coordinator.pushToHistory(loadWebViewSubject: loadWebViewSubject)
    }
    
    func saveHistory(with history: HistoryModel) {
        inputs.sqliteHistoryManager.save(history: history)
    }
}
