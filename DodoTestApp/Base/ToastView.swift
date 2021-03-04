//
//  ToastView.swift
//  DodoTestApp
//
//  Created by Кирилл Елсуфьев on 04.03.2021.
//

import UIKit

class ToastView: UIView {
    
    fileprivate let titleLabel: UILabel = CustomLabel(text: "", textColor: .white)
    
    var cancelDidTap: (() -> ())?
    var timerElapsed: (() -> ())?

    fileprivate var timer: Timer?
    
    fileprivate lazy var cancelButton: UIButton = {
    
        let button = UIButton(type: .system)
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.titleLabel?.font = UIFont(name: Constant.FONT_REGULAR, size: Constant.SIZE_MEDIUM)
        
        button.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
        
        return button
        
    }()
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(0x36393d)
        self.layer.cornerRadius = self.bounds.height / 2
        
        addSubview(titleLabel)
        addSubview(cancelButton)
        
        titleLabel.text = title
        
        setupTimer()
    }
    
    func setupTimer() {
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] (timer) in
            
            guard let self = self else { return }
            
            UIView.animate(withDuration: 0.4, animations: {
                self.frame.origin.y = UIScreen.main.bounds.height
            }, completion: { (completed) in
                if completed {
                    self.removeFromSuperview()
                }
            })
            
            self.timerElapsed?()
            
        }

    }
    
    func dismiss() {
        
        self.timer?.invalidate()

        UIView.animate(withDuration: 0.4, animations: {
            self.alpha = 0.0
        }, completion: { (completed) in
            if completed {
                self.removeFromSuperview()
            }
        })

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cancelButtonDidTap() {
        
        cancelDidTap?()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
    }
    
    func layoutUI() {
        
        self.titleLabel.pin.topLeft().bottom().marginLeft(30).sizeToFit(.height)
        self.cancelButton.pin.topRight().bottom().width(60).marginRight(30)
        
    }
    
    
    deinit {
        print("toast view deinit")
    }
    
    
}

