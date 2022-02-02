//
//  ColorTheme.swift
//  QuotesGenerator
//
//  Created by 장일규 on 2022/02/02.
//

import UIKit

enum ColorTheme {
    case white
    
    var color: UIColor {
        switch self {
            case .white:
            return UIColor(r: 230, g: 230, b: 230)
        }
    }
}

extension UIColor {
    public convenience init(
        r: Int,
        g: Int,
        b: Int,
        alpha: CGFloat = 1.0
    ) {
        self.init(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: alpha
        )
    }
}
