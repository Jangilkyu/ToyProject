//
//  MainViewController.swift
//  Covid19
//
//  Created by 장일규 on 2022/01/30.
//

import Foundation
import UIKit
import Charts

class MainViewController: UIViewController {
    
    let domConfirmedCase: UILabel = {
        let domConfirmedCase = UILabel()
        domConfirmedCase.text = "국내 확진자"
        domConfirmedCase.textColor = .black
        
        return domConfirmedCase
    }()
    
    let domConfirmedCaseCnt: UILabel = {
        let domConfirmedCaseCnt = UILabel()
        domConfirmedCaseCnt.text = "Label"
        domConfirmedCaseCnt.textColor = .black
        
        return domConfirmedCaseCnt
    }()
    
    let domConfirmedCaseStackView: UIStackView = {
        let domConfirmedCaseStackView = UIStackView()
        domConfirmedCaseStackView.axis = .vertical
        domConfirmedCaseStackView.alignment = .center
        domConfirmedCaseStackView.spacing = 20
        return domConfirmedCaseStackView
    }()
    
    // =====
    
    let domNewConfirmedCase: UILabel = {
        let domNewConfirmedCase = UILabel()
        domNewConfirmedCase.text = "국내 신규 확진자"
        domNewConfirmedCase.textColor = .black
        
        return domNewConfirmedCase
    }()
    
    let domNewConfirmedCaseCnt: UILabel = {
        let domNewConfirmedCaseCnt = UILabel()
        domNewConfirmedCaseCnt.text = "Label"
        domNewConfirmedCaseCnt.textColor = .black
        
        return domNewConfirmedCaseCnt
    }()
    
    let domNewConfirmedCaseStackView: UIStackView = {
        let domNewConfirmedCaseStackView = UIStackView()
        domNewConfirmedCaseStackView.axis = .vertical
        domNewConfirmedCaseStackView.alignment = .center
        domNewConfirmedCaseStackView.spacing = 20
        
        return domNewConfirmedCaseStackView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.backgroundColor = .blue
        stackView.alignment = .center
        
        return stackView
    }()
    
    let chartUIView: UIView = {
        let chartUIView = UIView()
        chartUIView.backgroundColor = .systemPink
        return chartUIView
    }()
    
    
    // ====
    override func viewDidLoad() {
        view.backgroundColor = .white
        setup()
    }
    
    func setup() {
        addViews()
        setConstraints()
    }
    
    func addViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(domConfirmedCaseStackView)
        stackView.addArrangedSubview(domNewConfirmedCaseStackView)

//        view.addSubview(domConfirmedCaseStackView)
        domConfirmedCaseStackView.addArrangedSubview(domConfirmedCase)
        domConfirmedCaseStackView.addArrangedSubview(domConfirmedCaseCnt)
        
//        view.addSubview(domNewConfirmedCaseStackView)
        domNewConfirmedCaseStackView.addArrangedSubview(domNewConfirmedCase)
        domNewConfirmedCaseStackView.addArrangedSubview(domNewConfirmedCaseCnt)
        
        view.addSubview(chartUIView)
    }
    
    func setConstraints() {
        domConfirmedCaseStackViewConstraints()
        domNewConfirmedCaseStackViewConstratins()
        stackViewConstratins()
        chartUIViewConstraints()
    }
    
    func domConfirmedCaseStackViewConstraints() {
        domConfirmedCaseStackView.translatesAutoresizingMaskIntoConstraints = false
//        domConfirmedCaseStackView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func domNewConfirmedCaseStackViewConstratins() {
        domNewConfirmedCaseStackView.translatesAutoresizingMaskIntoConstraints = false
    }
        
    func stackViewConstratins() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    }
    
    func chartUIViewConstraints() {
        chartUIView.translatesAutoresizingMaskIntoConstraints = false
        chartUIView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        chartUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        chartUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chartUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
