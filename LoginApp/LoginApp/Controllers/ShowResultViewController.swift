//
//  ShowResultViewController.swift
//  LoginApp
//
//  Created by 장일규 on 2022/02/05.
//

import Foundation
import UIKit
import Firebase

class ShowResultViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}
