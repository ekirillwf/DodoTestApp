//
//  BaseView.swift
//  DodoTestApp
//
//  Created by Кирилл Елсуфьев on 04.03.2021.
//

import UIKit

class BaseView: UIView {
    
    fileprivate (set) var topLayoutGuide: CGFloat = 0
    fileprivate (set) var bottomLayoutGuide: CGFloat = 0
    
    fileprivate weak var controller: UIViewController?
    
    init(controller: UIViewController) {
        super.init(frame: UIScreen.main.bounds)
        self.controller = controller
        backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayoutGuides(top: CGFloat, bottom: CGFloat) {
        var didChange = false
        
        if top != topLayoutGuide {
            topLayoutGuide = top
            didChange = true
        }
        
        if bottom != bottomLayoutGuide {
            bottomLayoutGuide = bottom
            didChange = true
        }
        
        if didChange {
            didChangeLayoutGuides()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        topLayoutGuide = controller?.topLayoutGuide.length ?? 0
        bottomLayoutGuide = controller?.bottomLayoutGuide.length ?? 0
        
    }
    
    //MARK: - this methods must be overrided for successors
    
    func keyboardWillShow(keyboardHeight: CGFloat) {
        
    }
    
    func keyboardWillHide() {
        
    }
    
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let sizeValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        keyboardWillShow(keyboardHeight: sizeValue.cgRectValue.height)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        keyboardWillHide()
    }
    
    
    func didChangeLayoutGuides() {
        setNeedsLayout()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
}

