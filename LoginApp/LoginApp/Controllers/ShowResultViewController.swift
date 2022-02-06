//
//  ShowResultViewController.swift
//  LoginApp
//
//  Created by 장일규 on 2022/02/05.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

class ShowResultViewController: UIViewController {
    
    let loginSuccessLabel: UILabel = {
      let loginSuccessLabel = UILabel()
        loginSuccessLabel.text = "환영합니다."
        loginSuccessLabel.textColor = .white
        loginSuccessLabel.numberOfLines = 0
        return loginSuccessLabel
    }()
    
    let logoutButton: UIButton = {
        let logoutButton = UIButton()
        logoutButton.setTitle("로그아웃", for: .normal)
        
        return logoutButton
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        setup()
    }
    
    func setup() {
        addViews()
        setConstraints()
    }
    
    func addViews() {
        view.addSubview(loginSuccessLabel)
        view.addSubview(logoutButton)
    }
    
    func setConstraints() {
        loginSuccessLabelConstraints()
        logoutButtonConstraints()
    }
    
    func loginSuccessLabelConstraints() {
        loginSuccessLabel.translatesAutoresizingMaskIntoConstraints = false
        loginSuccessLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginSuccessLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func logoutButtonConstraints() {
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.topAnchor.constraint(equalTo: loginSuccessLabel.centerYAnchor, constant: 50).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        
        // Google Sign In
        GIDSignIn.sharedInstance().presentingViewController = self
    }
}
