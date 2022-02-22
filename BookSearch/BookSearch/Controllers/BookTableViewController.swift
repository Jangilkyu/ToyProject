//
//  BookTableViewController.swift
//  BookSearch
//
//  Created by 장일규 on 2022/02/22.
//

import Foundation
import UIKit
import Reusable
import Alamofire

class BookTableViewController: UIViewController {
    
    let bookTableView: UITableView = {
      let bookTableView = UITableView()
      
        return bookTableView
    }()
    
    let uiSearchController: UISearchController = {
      let uiSearchController = UISearchController()
        uiSearchController.searchResultsUpdater = nil
        return uiSearchController
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setup()
        setConstraints()
        setConfigureTableView()
        self.navigationItem.title = "📚원하는 책을 찾아보세요!🤗"
        self.navigationItem.searchController = uiSearchController
    }
    
    func setup() {
        view.addSubview(bookTableView)
    }
    func setConstraints() {
        bookTableView.translatesAutoresizingMaskIntoConstraints = false
        bookTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bookTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bookTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bookTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setConfigureTableView() {
        bookTableView.register(cellType: BookTableCell.self)
        bookTableView.delegate = self
        bookTableView.dataSource = self
    }
}


extension BookTableViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 2
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as BookTableCell
        
        return cell
    }
    
    
}

extension BookTableViewController: UITableViewDelegate {
    
}

