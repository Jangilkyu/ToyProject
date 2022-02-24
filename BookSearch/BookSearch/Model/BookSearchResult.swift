//
//  BookSearchResult.swift
//  BookSearch
//
//  Created by 장일규 on 2022/02/22.
//

import Foundation


struct BookSearchResult: Codable {
    struct BookInfo: Codable {
        let title: String
        let author: String
        let discount: String
        let pubdate: String
    }
    
    let items: [BookInfo]
}


