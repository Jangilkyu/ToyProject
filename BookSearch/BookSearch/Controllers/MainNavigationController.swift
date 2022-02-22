//
//  MainNavigationController.swift
//  BookSearch
//
//  Created by 장일규 on 2022/02/22.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        viewControllers = [BookTableViewController()]
    }
}
