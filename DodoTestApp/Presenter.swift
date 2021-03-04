//
//  Presenter.swift
//  DodoTestApp
//
//  Created by Кирилл Елсуфьев on 04.03.2021.
//

import UIKit
import SwiftyJSON

protocol Delegate: AnyObject {
    func allLoaded()
}

class Presenter {



    weak var delegate: Delegate?
    var dispatchGroup = DispatchGroup()
    
    
    private let decoder = JSONDecoder()
    
    func notify() {
        self.dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            self?.delegate?.allLoaded()
        }
    }
    
    func loadData() {

        self.dispatchGroup.enter()
        self.dispatchGroup.leave()

        notify()
    }
    
}

