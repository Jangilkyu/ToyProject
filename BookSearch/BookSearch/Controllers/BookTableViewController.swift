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
    
    var items: [BookSearchResult.BookInfo] = []
    
    let bookTableView: UITableView = {
      let bookTableView = UITableView()
      
        return bookTableView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setup()
        setConstraints()
        setConfigureTableView()
        setSearchBar()
//        self.navigationItem.title = "📚원하는 책을 찾아보세요!🤗"
        fetchBooks()
        
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
    
    func setSearchBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "📖찾고자 하는 책을 검색해보세요.!🔎"
        // left search ICon Img SET
//        searchBar.setImage(UIImage(named: "search"), for: UISearchBar.Icon.search, state: .normal)
        // right cancelButton Img SET
//        searchBar.setImage(UIImage(named: "cancel"), for: .clear, state: .normal)
        
        self.navigationController?.navigationBar.topItem?.titleView = searchBar

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



extension BookTableViewController {
    
    func fetchBooks() {
        AF.request(
            "https://openapi.naver.com/v1/search/book.json?query=swift",
            headers: [
                       "X-Naver-Client-Id": Storage().clientID,
                       "X-Naver-Client-Secret" : Storage().clientSecret
            ]).validate().responseDecodable(of: BookSearchResult.self) {
                (response) in
                switch response.result {
                    case .success(let obj):
                        print(obj)
                    case .failure(let e):
                        print(e.localizedDescription)
                }
                
                guard let booksearchResult = response.value else { return }
                print(booksearchResult.items[0].title)
            }
    }
}


