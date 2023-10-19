//
//  NNToast.swift
//  NiuNiuRent
//
//  Created by Q Z on 2023/4/25.
//

import UIKit
import FoundationEx
import Toast

open class Toast: NSObject {
    
    static let `default`: Toast = {
        return Toast()
    }()
    
    static let autoDismissTime: TimeInterval = 2
    
    public func showError(_ message: String?, clearTime: TimeInterval = 2) {
        if let message = message {
            Toast.showError(message, clearTime: clearTime)
        }
    }
    
    public func showSuccess(_ message: String?, clearTime: TimeInterval = 2) {
        if let message = message {
            Toast.showSuccess(message, clearTime: clearTime)
        }
    }
    
    public func showWarning(_ message: String?, clearTime: TimeInterval = 2) {
        if let message = message {
            Toast.showInfo(message, clearTime: clearTime)
        }
    }
    
    public func wait() {
        Toast.wait()
    }
    
    public func clear() {
        Toast.clear()
    }
    
    static func showToast(_ view: UIView, message: String, image: UIImage?, clearTime: TimeInterval = autoDismissTime, completion: ((_ didTap: Bool)->())? = nil) {
        DispatchQueue.main.async {
            var style = ToastStyle()
            style.messageFont = UIFont.systemFont(ofSize: 15, weight: .regular)
            style.messageColor = .white
            style.backgroundColor = .black.withAlphaComponent(0.6)
            style.messageAlignment = .center
            style.imageSize = CGSize(width: 20, height: 20)
            view.makeToast(message, duration: clearTime, position: .top, image: image, style: style, completion: completion)
        }
    }
    
    static func showToast(_ message: String, image: UIImage?, clearTime: TimeInterval = autoDismissTime, completion: ((_ didTap: Bool)->())? = nil) {
        DispatchQueue.main.async {
            guard let view = (UIApplication.shared.nn_keyWindow ?? self.topmostViewController?.view) else { return }
            self.showToast(view, message: message, image: image, clearTime: clearTime, completion: completion)
        }
    }
    
    static func showSuccess(_ message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        showToast(message, image: UIImage(named: "code_icon_alert"), clearTime: clearTime, completion: completion)
    }
    
    static func showError(_ message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        showToast(message, image: UIImage(named: "code_icon_fail"), clearTime: clearTime, completion: completion)
    }
    
    static func showInfo(_ message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        showToast(message, image: UIImage(named: "code_icon_alert"), clearTime: clearTime, completion: completion)
    }
    
    static func showSuccess(_ view: UIView, message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        self.showToast(view, message: message, image: UIImage(named: "icon_success_application"), clearTime: clearTime, completion: completion)
    }
    
    static func showError(_ view: UIView, message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        self.showToast(view, message: message, image: UIImage(named: "code_icon_fail"), clearTime: clearTime, completion: completion)
    }
    
    static func showInfo(_ view: UIView, message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        self.showToast(view, message: message, image: UIImage(named: "code_icon_alert"), clearTime: clearTime, completion: completion)
    }
    
    static func wait() {
        self.topmostViewController?.view.makeToastActivity(.center)
    }
    
    static func clear() {
        self.topmostViewController?.view.hideToast()
    }
    
    static func clearAll() {
        self.topmostViewController?.view.hideAllToasts()
    }
    
}

