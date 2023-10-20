//
//  HUD.swift
//  NiuNiuRent
//
//  Created by 张泉 on 2023/4/19.
//

import UIKit
import ProgressHUD

open class HUD: NSObject {
    
    public static let `default`: HUD = {
        return HUD()
    }()
    
    public func showError(_ message: String?, clearTime: TimeInterval = 1.5) {
        if let message = message {
            HUD.showError(message, clearTime: clearTime)
        }
    }
    
    public func showSuccess(_ message: String?, clearTime: TimeInterval = 1.5) {
        if let message = message {
            HUD.showSuccess(message)
        }
    }
    
    public func showWarning(_ message: String?, clearTime: TimeInterval = 1.5) {
        if let message = message {
            HUD.showInfo(message)
        }
    }
    
    public func wait() {
        HUD.wait()
    }
    
    public func clear() {
        HUD.clear()
    }
    
    public class func defaultDeploy() {
        ProgressHUD.imageSuccess = loadImageBundle(named: "icon_success_application")
        ProgressHUD.imageError = loadImageBundle(named: "code_icon_fail")
        ProgressHUD.colorAnimation = .white
        ProgressHUD.colorBackground = .black.withAlphaComponent(0.4)
        ProgressHUD.colorHUD = .black
        ProgressHUD.colorStatus = .white
        ProgressHUD.mediaSize = 60
        ProgressHUD.marginSize = 20
        ProgressHUD.fontStatus = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    public class func showSuccess(_ message: String, clearTime: TimeInterval = 1.5, completion: (@Sendable @convention(block) () -> Void)? = nil) {
        self.updateImageSize()
        ProgressHUD.success(message, interaction: false, delay: clearTime)
        if let completion = completion {
            DispatchQueue.main.asyncAfter(deadline: .now() + clearTime, execute: completion)
        }
    }
    
    public class func showError(_ message: String, clearTime: TimeInterval = 1.5, completion: (@Sendable @convention(block) () -> Void)? = nil) {
        self.updateImageSize()
        ProgressHUD.imageError = loadImageBundle(named: "code_icon_fail")
        ProgressHUD.failed(message, interaction: false, delay: clearTime)
        if let completion = completion {
            DispatchQueue.main.asyncAfter(deadline: .now() + clearTime, execute: completion)
        }
    }

    public class func showInfo(_ message: String, clearTime: TimeInterval = 1.5, completion: (@Sendable @convention(block) () -> Void)? = nil) {
        self.updateImageSize()
        ProgressHUD.image(message, image: loadImageBundle(named: "code_icon_alert"), interaction: false, delay: clearTime)
        if let completion = completion {
            DispatchQueue.main.asyncAfter(deadline: .now() + clearTime, execute: completion)
        }
    }
    
    private class func updateImageSize() {
        ProgressHUD.mediaSize = 40
    }
    
    public class func wait() {
        HUD.wait("加载中...")
    }
    
    public class func wait(_ info: String? = nil, _ type: AnimationType = .circleArcDotSpin, isEnabled: Bool = false) {
        ProgressHUD.animate(info, type, interaction: isEnabled)
    }
    
    public class func animate(_ text: String? = nil, _ type: AnimationType, interaction: Bool = true) {
        ProgressHUD.animate(text, type, interaction: interaction)
    }
    
    public class func wait(progress: CGFloat, status: String) {
        ProgressHUD.progress(status, progress, interaction: false)
    }
    
    public class func clear() {
        ProgressHUD.remove()
    }
    
    public class func dismiss() {
        ProgressHUD.dismiss()
    }
    
    private class func loadImageBundle(named name: String) -> UIImage {
        let primaryBundle = Bundle(for: HUD.self)
        if let image = UIImage(named: name, in: .module, compatibleWith: nil) {
            // Load image from SPM if available
            return image
        } else if let image = UIImage(named: name, in: primaryBundle, compatibleWith: nil) {
            // Load image in cases where PKHUD is directly integrated
            return image
        } else if
            let subBundleUrl = primaryBundle.url(forResource: "HUD", withExtension: "bundle"),
            let subBundle = Bundle(url: subBundleUrl),
            let image = UIImage(named: name, in: subBundle, compatibleWith: nil)
        {
            return image
        }
        
        return UIImage()
    }
}

