//
//  MainNavigationController.swift
//  Covid19
//
//  Created by 장일규 on 2022/01/30.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
//        viewControllers = [MainViewController()]
        viewControllers = [CovidDetailViewController()]
    }
}
