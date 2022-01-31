//
//  CovidCell.swift
//  Covid19
//
//  Created by 장일규 on 2022/01/31.
//

import Foundation
import UIKit

class CovidCell: UITableViewCell {
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
