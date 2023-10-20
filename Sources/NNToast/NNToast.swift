//
//  NNToast.swift
//  NiuNiuRent
//
//  Created by Q Z on 2023/4/25.
//

import UIKit
import FoundationEx
import Toast
import Foundation
open class Toast: NSObject {
    private static let errorImage = loadImageBundle(named: "code_icon_fail")
    private static let successImage = loadImageBundle(named: "icon_success_application")
    private static let infoImage = loadImageBundle(named: "code_icon_alert")
    public static let `default`: Toast = {
        return Toast()
    }()
    
    public static let autoDismissTime: TimeInterval = 2
    
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
    
    public static func showToast(_ view: UIView, message: String, image: UIImage?, clearTime: TimeInterval = autoDismissTime, completion: ((_ didTap: Bool)->())? = nil) {
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
    
    public static func showToast(_ message: String, image: UIImage?, clearTime: TimeInterval = autoDismissTime, completion: ((_ didTap: Bool)->())? = nil) {
        DispatchQueue.main.async {
            guard let view = (UIApplication.shared.nn_keyWindow ?? self.topmostViewController?.view) else { return }
            self.showToast(view, message: message, image: image, clearTime: clearTime, completion: completion)
        }
    }
    
    public static func showSuccess(_ message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        showToast(message, image: successImage, clearTime: clearTime, completion: completion)
    }
    
    public static func showError(_ message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        showToast(message, image: errorImage, clearTime: clearTime, completion: completion)
    }
    
    public static func showInfo(_ message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        showToast(message, image: infoImage, clearTime: clearTime, completion: completion)
    }
    
    public static func showSuccess(_ view: UIView, message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        self.showToast(view, message: message, image: successImage, clearTime: clearTime, completion: completion)
    }
    
    public static func showError(_ view: UIView, message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        self.showToast(view, message: message, image: errorImage, clearTime: clearTime, completion: completion)
    }
    
    public static func showInfo(_ view: UIView, message: String, clearTime: TimeInterval = autoDismissTime,  completion: ((_ didTap: Bool)->())? = nil) {
        self.showToast(view, message: message, image: infoImage, clearTime: clearTime, completion: completion)
    }
    
    public static func wait() {
        self.topmostViewController?.view.makeToastActivity(.center)
    }
    
    public static func clear() {
        self.topmostViewController?.view.hideToast()
    }
    
    public static func clearAll() {
        self.topmostViewController?.view.hideAllToasts()
    }
    
    fileprivate class func loadImageBundle(named name: String) -> UIImage {
        let primaryBundle = Bundle(for: Toast.self)
        if let image = UIImage(named: name, in: .module, compatibleWith: nil) {
            // Load image from SPM if available
            return image
        } else if let image = UIImage(named: name, in: primaryBundle, compatibleWith: nil) {
            // Load image in cases where PKHUD is directly integrated
            return image
        } else if
            let subBundleUrl = primaryBundle.url(forResource: "NNToast", withExtension: "bundle"),
            let subBundle = Bundle(url: subBundleUrl),
            let image = UIImage(named: name, in: subBundle, compatibleWith: nil)
        {
            return image
        }
        
        return UIImage()
    }
}
