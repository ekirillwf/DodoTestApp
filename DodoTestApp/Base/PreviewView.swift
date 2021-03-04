//
//  PreviewView.swift
//  DodoTestApp
//
//  Created by Кирилл Елсуфьев on 04.03.2021.
//

import UIKit

class PreviewView: BaseView {

    weak fileprivate var controller: PreviewVC!
    var visibleHeight: CGFloat = 0.0
    
    var originY: CGFloat = 0.0
    var progress: CGFloat = 0.0

    lazy var draggingArea: UIView = {
        
        let view = UIView()
        
        return view
        
    }()

    let draggingView: UIView = {
       
        let view = UIView()
        view.backgroundColor = UIColor(0xd8d8d8)
        view.bounds.size = CGSize(width: 68, height: 6)
        view.layer.cornerRadius = 3
        
        return view
        
    }()
    
    init(controller: PreviewVC) {
        super.init(controller: controller)
        self.controller = controller
        
        self.layer.cornerRadius = 16.0
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.3
        
        addSubview(draggingView)
        addSubview(draggingArea)
        
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(panGestureBegin(_:)))
        self.addGestureRecognizer(panGR)

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
    }
    
    func layoutUI() {
        
        draggingView.pin.top().hCenter().marginTop(10)
        draggingArea.pin.topLeft().right().height(40)
                
    }

    @objc func panGestureBegin(_ sender: UIPanGestureRecognizer) {
        
        guard let superView = sender.view?.superview else { return }
        
        switch sender.state {
        case .changed:
            
            let translation = sender.translation(in: superView)

            progress = translation.y / self.visibleHeight

            self.frame.origin = CGPoint(x: 0, y: fmax(originY, originY + translation.y))

            self.controller.onDragging?(1.0 - progress)
            
        case .ended:
            
            let endPoint = progress > 0.3 ? UIScreen.main.bounds.height: originY
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: { [weak self] in
                
                self?.frame.origin.y = endPoint
                
            }, completion: { [weak self] (completed) in
                if completed && endPoint == UIScreen.main.bounds.height {
                    self?.controller.onDismiss?()
                }
            })

        default:
            break
        }
        
    }
    
    deinit {
        print("deinit PreivewView")
    }
    
    
}

