//
//  ViewController.swift
//  DodoTestApp
//
//  Created by Кирилл Елсуфьев on 04.03.2021.
//

import UIKit

class ViewController: BaseVC {
    
    enum State {
        case full
        case short
    }
    
    enum LikeState {
        case like
        case unlike
    }
    
    fileprivate var selectedCategoryIndex = -1
    
    private let presenter: Presenter
    
    fileprivate var mainView: View {
        return self.view as! View
    }
    
    override func loadView() {
        view = View(controller: self)
    }
    
    init(with presenter: Presenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "DODO"
        self.mainView.backgroundColor = .white
//        mainView.tableView.backgroundColor = .white
//        mainView.showLoadIndicator()
        setupBarButtonItems()
        
        presenter.loadData()
//        mainView.tableView.reloadData()
        

    }
    
    func setupBarButtonItems() {
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(showFilterBar))]
    }
    
    @objc func showFilterBar() {
        
    }
    
}

extension ViewController: Delegate {
    
    func allLoaded() {

//        mainView.hideLoadIndicator()
//        self.mainView.tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func update() {
        self.mainView.tableView.beginUpdates()
        self.mainView.tableView.endUpdates()
    }
    
}


