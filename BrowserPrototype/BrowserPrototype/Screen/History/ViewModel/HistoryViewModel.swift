//
//  HistoryViewModel.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import Combine
import Foundation

final class HistoryViewModel {
    private weak var coordinator : MainCoordinator!
    private let deleteHistorySubject = PassthroughSubject<Void, Never>()
    private var loadWebViewSubject = PassthroughSubject<String, Never>()
    var inputs: HistoryInputs
    var navigationTitle: String = "History"
    var deleteHistoryPublisher: AnyPublisher<Void, Never> {
        return deleteHistorySubject.eraseToAnyPublisher()
    }
    var items: [HistoryModel] = [] {
        didSet {
            deleteHistorySubject.send()
        }
    }
    
    init(inputs: HistoryInputs) {
        self.inputs = inputs
    }
    
    func setup(coordinator: MainCoordinator, loadWebViewSubject: PassthroughSubject<String, Never>) {
        self.coordinator = coordinator
        self.loadWebViewSubject = loadWebViewSubject
    }
    
    func getHistory() {
        items = inputs.historyService.getAllHistory().sorted(by: { $0.date.compare($1.date) == .orderedDescending })
    }
    
    func deleteHistory() {
        inputs.historyService.deleteHistory()
        items = []
    }
    
    func select(historyModel: HistoryModel) {
        loadWebViewSubject.send(historyModel.url)
    }
}
