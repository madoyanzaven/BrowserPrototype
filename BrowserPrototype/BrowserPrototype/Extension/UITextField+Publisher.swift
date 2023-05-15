//
//  UITextField+Publisher.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import Combine
import UIKit

extension UITextField {
    var editingDidEndOnExitPublisher: AnyPublisher<String, Never> {
        return publisher(for: .editingDidEndOnExit)
            .compactMap { [weak self] _ in
                return self?.text
            }
            .eraseToAnyPublisher()
    }
}
