//
//  HistoryViewController.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import Combine
import SnapKit
import UIKit

final class HistoryViewController: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    private let primaryGreen = Constants.Colors.primaryGreen
    lazy var navigationBarView: NavigationBarView = {
        let navigationBarView = NavigationBarView.instanceFromNib()
        navigationBarView.backgroundColor = primaryGreen
        navigationBarView.setup(with: viewModel.navigationTitle)
        
        return navigationBarView
    }()
    lazy var emptyHistoryView: EpmtyHistoryView = {
        let emptyView = EpmtyHistoryView.instanceFromNib()
        emptyView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        emptyView.backgroundColor = .white
        
        return emptyView
    }()
    lazy var historyTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .white
        tableView.layer.masksToBounds  = true
        tableView.layer.cornerRadius = 20
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return tableView
    }()
    private let heightForRowAt: CGFloat = 80
    private let heightForHeader: CGFloat = 20
    let viewModel: HistoryViewModel = HistoryViewModel(inputs: HistoryInputs(sqliteHistoryManager: SQLiteHistoryManager.shared))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindToView()
        registerTableView()
        viewModel.getHistory()
    }
    
    private func setupViews() {
        setupNavigationBarView()
        setupTableView()
        setupEmptyHistoryView()
        view.backgroundColor = primaryGreen
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupNavigationBarView() {
        view.addSubview(navigationBarView)
        navigationBarView.snp.makeConstraints({
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(44)
        })
    }
    
    private func setupTableView() {
        view.addSubview(historyTableView)
        
        historyTableView.snp.makeConstraints({
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
    }
    
    private func setupEmptyHistoryView() {
        view.addSubview(emptyHistoryView)
        emptyHistoryView.snp.makeConstraints({
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
    }
    
    private func bindToView() {
        navigationBarView.backButtonPublisher.sinkOnMain { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }.store(in: &subscriptions)
        
        navigationBarView.deleteButtonPublisher.sinkOnMain { [weak self] in
            guard let self = self else { return }
            self.viewModel.deleteHistory()
        }.store(in: &subscriptions)
        
        viewModel.deleteHistoryPublisher.sinkOnMain { [weak self] in
            guard let self = self else { return }
            self.historyTableView.reloadData()
        }.store(in: &subscriptions)
    }
    
    private func registerTableView() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.separatorStyle = .none
        historyTableView.register(HistoryTableViewCell.self)
    }
    
    private func hideView(isEmpty: Bool) {
        navigationBarView.hideDeleteButton(hide: isEmpty)
        emptyHistoryView.isHidden = !isEmpty
        historyTableView.isHidden = isEmpty
    }
}

// MARK: UITableViewDataSource

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = viewModel.items
        hideView(isEmpty: items.isEmpty)
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HistoryTableViewCell = historyTableView.dequeueReusableCell(forIndexPath: indexPath)
        let currentItem = viewModel.items[safe: indexPath.row]
        cell.selectionStyle = .none
        
        cell.setup(model: currentItem)
        
        return cell
    }
}

// MARK: UITableViewDelegate

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeader
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentItem = viewModel.items[safe: indexPath.row] else { return }
        
        viewModel.select(historyModel: currentItem)
        navigationController?.popViewController(animated: true)
    }
}
