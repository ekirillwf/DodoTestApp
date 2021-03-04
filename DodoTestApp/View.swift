//
//  View.swift
//  DodoTestApp
//
//  Created by Кирилл Елсуфьев on 04.03.2021.
//

import UIKit

class View: BaseView {
    
    weak var controller: ViewController!
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = controller
        tableView.delegate = controller
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.delaysContentTouches = false
        
//        tableView.register(BlogsCell.self, forCellReuseIdentifier: BlogsCell.identifier)
//        tableView.register(BlogsCollectionCell.self, forCellReuseIdentifier: BlogsCollectionCell.identifier)
        return tableView
    }()

    
    fileprivate lazy var loadIndicator: UIActivityIndicatorView = {
        
        let view = UIActivityIndicatorView()
//        view.color = Constant.SECONDARY_COLOR
        view.hidesWhenStopped = true
        
        return view
        
    }()
    
    init(controller: ViewController) {
        super.init(controller: controller)
        self.controller = controller
        
        addSubview(tableView)
        addSubview(loadIndicator)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
    }
    
    fileprivate func layoutUI() {
        tableView.pin.all()
        loadIndicator.pin.hCenter().vCenter()
    }

    public func showLoadIndicator() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        loadIndicator.startAnimating()
        
    }
    
    public func hideLoadIndicator() {
        UIApplication.shared.endIgnoringInteractionEvents()
        loadIndicator.stopAnimating()
        
    }
    
}



