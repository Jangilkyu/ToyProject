//
//  CovidDetailViewController.swift
//  Covid19
//
//  Created by 장일규 on 2022/01/30.
//

import Foundation
import UIKit

class CovidDetailViewController: UIViewController {
    
    var covidOverview: CovidOverview?
    
    let titleCase: [String] = ["신규 확진자", "확진자", "완치자", "사망자", "발생률", "해외유입 신규 확진자", "지역발생 신규 확진자"]
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
//        tableView.backgroundColor = .systemPink
        return tableView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setup()
    }
    
    func setup() {
        addViews()
        setConstraints()
        setConfigureTableView()
        configureView()
    }
    
    func addViews() {
        view.addSubview(tableView)
    }
    
    func setConstraints() {
        tableViewConstratins()
    }
    
    func setConfigureTableView() {
        tableView.register(CovidCell.self, forCellReuseIdentifier: "CovidCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableViewConstratins() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func configureView() {
        guard let covidOverview = self.covidOverview else { return }
        self.title = covidOverview.countryName
//        self.newCaseCell.
    }

}

extension CovidDetailViewController:
    UITableViewDelegate,
    UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return titleCase.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CovidCell") as? CovidCell else { return UITableViewCell() }
        
        let target = titleCase[indexPath.row]
//        print(target)
        cell.textLabel?.text = target
        
        cell.detailTextLabel?.textColor = .black
        cell.detailTextLabel?.text = "data"
//        print(covidOverview)
    
        return cell
    }
    
    
    
}
