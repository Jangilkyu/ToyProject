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
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.adjustsFontSizeToFitWidth = true
        
        return titleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()

    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addViews()
        setConstraints()
    }
    
    func addViews() {
        addSubview(titleLabel)
    }
    
    func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
}

extension BookTableCell: Reusable {
    
}
