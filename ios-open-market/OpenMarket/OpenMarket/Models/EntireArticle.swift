//
//  EntireArticle.swift
//  OpenMarket
//
//  Created by sookim on 2021/05/11.
//

import Foundation

struct EntireArticle: Decodable {
    
    let page: Int
    let items: [EssentialArticle]
    
}
