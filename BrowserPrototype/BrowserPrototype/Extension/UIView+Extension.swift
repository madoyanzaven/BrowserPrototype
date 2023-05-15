//
//  UIView+Extension.swift
//  BrowserPrototype
//
//  Created by Zaven Madoyan on 15.05.23.
//

import UIKit

extension UIView {
    var className: String {
        return String(describing: type(of: self))
    }
    class var className: String {
        return String(describing: self)
    }
}

protocol InstanceFromNibProtocol {
    associatedtype InstanceFromNibType: UIView
    static func instanceFromNib() -> InstanceFromNibType
}

extension InstanceFromNibProtocol {
    static func instanceFromNib() -> InstanceFromNibType {
        let nibName = InstanceFromNibType.className
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! InstanceFromNibType
    }
}
