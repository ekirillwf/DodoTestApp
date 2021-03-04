//
//  PreviewVC.swift
//  DodoTestApp
//
//  Created by Кирилл Елсуфьев on 04.03.2021.
//

import UIKit

class PreviewVC: BaseVC {

    public var onCalculateHeight: ((CGFloat) -> Void)?
    public var onDragging: ((CGFloat) -> Void)?
    public var onDismiss: (() -> Void)?

    fileprivate var mainView: PreviewView {
        return self.view as! PreviewView
    }
    
    override func loadView() {
        view = PreviewView(controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    deinit {
        print("deinit PreviewVC")
    }
    
}

