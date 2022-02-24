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
    
    var items1: [BookSearchResult.BookInfo] = []
    
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
        searchBar.delegate = self
    }
    
    func setConfigureTableView() {
        bookTableView.register(cellType: BookTableCell.self)
        bookTableView.dataSource = self
        bookTableView.delegate = self
    }
}


extension BookTableViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        print(items1.count)
        return self.items1.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as BookTableCell
        cell.textLabel?.text =  items1[indexPath.row].title
        
        cell.detailTextLabel?.text = "Aa"
        print(items1[indexPath.row].discount)
       _ = items1.map { bookInfo in
//           print(bookInfo[indexPath.row].title)
        }
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 80
    }
}

extension BookTableViewController: UITableViewDelegate {

}

extension BookTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(
        _ searchBar: UISearchBar
    ) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(
        _ searchBar: UISearchBar
    ) {
        print("검색 버튼 이벤트")
        
        guard let searchResult = searchBar.text else { return }
        fetchBooks(for: searchResult)
    }
    
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        print("search = \(searchText)")
    }
}

extension BookTableViewController {
    
    func fetchBooks(for name: String) {
        let url = "https://openapi.naver.com/v1/search/book.json?"
        let parameters: [String: Any] = ["query": name, "display" : 100]
        AF.request(
            url, parameters: parameters,
            headers: [
                       "X-Naver-Client-Id": Storage().clientID,
                       "X-Naver-Client-Secret" : Storage().clientSecret
            ])
            .validate()
            .responseDecodable(of: BookSearchResult.self) {
                (response) in
                switch response.result {
                    case .success(let obj):
//                    print(obj.items)
                    self.items1 = obj.items
                    
                    DispatchQueue.main.async {
                        self.bookTableView.reloadData()
                    }

                    case .failure(let e):
                        print(e.localizedDescription)
                }
                
            }
    }
}


