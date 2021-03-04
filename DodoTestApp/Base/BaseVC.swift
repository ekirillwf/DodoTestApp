//
//  BaseVC.swift
//  DodoTestApp
//
//  Created by Кирилл Елсуфьев on 04.03.2021.
//

import UIKit
import FirebaseAnalytics
import SwiftKeychainWrapper
import PinLayout

protocol Previewable {
    var view: UIView! { get }
    func showPreview(previewVC: PreviewVC)
}

extension Previewable {
    
    func showPreview(previewVC: PreviewVC) {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let overlay = UIView(frame: UIScreen.main.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        overlay.alpha = 0.0
        
        window.rootViewController?.view.addSubview(overlay)
        
        window.rootViewController?.addChild(previewVC)
        window.rootViewController?.view.addSubview(previewVC.view)
        previewVC.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height)
        previewVC.didMove(toParent: window.rootViewController)
        
        previewVC.onCalculateHeight = { [weak previewVC] height in
            UIView.animate(withDuration: 0.4) {
                overlay.alpha = 1.0
                previewVC?.view.frame.origin.y = UIScreen.main.bounds.height - height
            }
        }
        
        previewVC.onDragging = { progress in

            overlay.alpha = progress
            
        }
        
        previewVC.onDismiss = { [weak previewVC] in
            previewVC?.willMove(toParent: nil)
            previewVC?.view.removeFromSuperview()
            previewVC?.removeFromParent()
            overlay.removeFromSuperview()
        }
        
    }

}

class BaseVC: UIViewController, Previewable {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.view.backgroundColor == nil {
            self.view.backgroundColor = .white
        }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Analytics.setScreenName(nil, screenClass: String(NSStringFromClass(type(of: self))))

    }
    
    //all successors must redefine this method
    func loadData() {
        
    }
    
    func showInfoAlert(title: String?, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showActionAlert(title: String, message: String, actionTitle: String, cancelTitle: String = "OK", handler: ((UIAlertAction) -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    func showDefaultActionAlert(title: String, message: String, actionTitle: String = "ОК", handler: ((UIAlertAction) -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func show(toastView: UIView) {
        
        self.tabBarController?.view.addSubview(toastView)
        
        UIView.animate(withDuration: 0.4) { [unowned self] in
            toastView.pin.bottom(self.view.pin.safeArea).marginBottom(10)
        }

    }
    
    func dismissToastView() {
        
        if let alreadyAddedToastViews = (self.tabBarController?.view.subviews.filter { return $0 is ToastView }) as? [ToastView] {
            for toastView in alreadyAddedToastViews {
                toastView.dismiss()
            }
        }
        
    }
    

    
    func showModal(vc: UIViewController) {
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        
        if let window = UIApplication.shared.keyWindow {
            window.rootViewController?.present(vc, animated: true, completion: nil)
        }
        
    }



    

    
    
    
}

