//
//  NavigationBarView.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import Combine
import UIKit

final class NavigationBarView: UIView, InstanceFromNibProtocol {
    typealias InstanceFromNibType = NavigationBarView
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var backButtonPublisher: AnyPublisher<Void, Never> {
        return backButton.touchUpInsidePublisher
    }
    var deleteButtonPublisher: AnyPublisher<Void, Never> {
        return deleteButton.touchUpInsidePublisher
    }
    
    func setup(with title: String?, hideBack: Bool = false) {
        guard let title = title else { return }
        backButton.isHidden = hideBack
        deleteButton.isHidden = hideBack
        titleLabel.text = title
    }
    
    func hideDeleteButton(hide: Bool) {
        deleteButton.isHidden = hide
    }
}

