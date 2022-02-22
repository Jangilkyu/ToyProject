//
//  BookTableCell.swift
//  BookSearch
//
//  Created by 장일규 on 2022/02/22.
//

import Foundation
import UIKit
import Reusable

class BookTableCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookTableCell: Reusable {
    
}
