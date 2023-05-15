//
//  HomeHeaderView.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import Combine
import UIKit

final class HomeHeaderView: UIView, InstanceFromNibProtocol {
    typealias InstanceFromNibType = HomeHeaderView
    @IBOutlet private weak var historyButton: UIButton!
    @IBOutlet private weak var inputTextField: UITextField!
    
    var historyButtonPublisher: AnyPublisher<Void, Never> {
        return historyButton.touchUpInsidePublisher
    }
    var inputTextFieldPublisher: AnyPublisher<String, Never> {
        return inputTextField.editingDidEndOnExitPublisher
    }
    
    func inputTextField(string: String) {
        inputTextField.text = string
    }
}
