//
//  HomeViewController.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import WebKit
import Combine
import SnapKit
import UIKit

final class HomeViewController: UIViewController, WKUIDelegate {
    private var subscriptions = Set<AnyCancellable>()
    private let primaryGreen = Constants.Colors.primaryGreen
    lazy var navigationBarView: NavigationBarView = {
        let navigationBarView = NavigationBarView.instanceFromNib()
        navigationBarView.backgroundColor = primaryGreen
        navigationBarView.setup(with: viewModel.navigationTitle, hideBack: true)
        
        return navigationBarView
    }()
    lazy var headerView: HomeHeaderView = {
        let header = HomeHeaderView.instanceFromNib()
        header.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return header
    }()
    lazy var webView: WKWebView = {
        var webView = WKWebView()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        return webView
    }()
    private let heightNavigationBar: CGFloat = 44
    private var currentUrl = String()
    let viewModel: HomeViewModel = HomeViewModel(inputs: HomeInputs(sqliteHistoryManager: SQLiteHistoryManager.shared))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindToView()
    }
    
    private func setupViews() {
        setupNavigationBarView()
        setupHeaderView()
        setupWebView()
        view.backgroundColor = primaryGreen
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupNavigationBarView() {
        view.addSubview(navigationBarView)
        navigationBarView.snp.makeConstraints({
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(heightNavigationBar)
        })
    }
    
    private func setupHeaderView() {
        view.addSubview(headerView)
        
        headerView.snp.makeConstraints({
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(80)
        })
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints({
            $0.top.equalTo(headerView.snp.bottom)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
    }
    
    private func bindToView() {
        headerView.historyButtonPublisher.sinkOnMain { [weak self] in
            guard let self = self else { return }
            self.headerView.inputTextField(string: "")
            self.viewModel.navigateToHistory()
        }.store(in: &subscriptions)
        
        headerView.inputTextFieldPublisher.sinkOnMain { [weak self] text in
            guard let self = self else { return }
            if self.viewModel.isValidURL(text) {
                self.currentUrl = text
            } else {
                let newURLString = text.lowercased().hasPrefix("https://www.") ? text : "https://www." + text
                self.currentUrl = newURLString
                self.headerView.inputTextField(string: newURLString)
            }
            self.loadWebView(with: self.currentUrl)
        }.store(in: &subscriptions)
        
        viewModel.loadWebViewPublisher.sinkOnMain { [weak self] url in
            guard let self = self else { return }
            self.currentUrl = url
            self.loadWebView(with: url)
        }.store(in: &subscriptions)
    }
    
    private func loadWebView(with urlString: String) {
        guard let url = URL(string: urlString),
              viewModel.hasAvailableNetwork() else { return }
        
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
}

extension HomeViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }
        let urlString = url.absoluteString
        if navigationAction.navigationType == .linkActivated {
            if UIApplication.shared.canOpenURL(url) {
                currentUrl = url.absoluteString
                viewModel.saveHistory(with: HistoryModel(url: urlString, date: Date()))
                decisionHandler(.allow)
            } else {
                decisionHandler(.cancel)
            }
        } else {
            viewModel.saveHistory(with: HistoryModel(url: urlString, date: Date()))
            decisionHandler(.allow)
        }
    }
}
