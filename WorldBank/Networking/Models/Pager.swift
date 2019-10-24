//
//  Pager.swift
//  WorldBank
//
//  Created by Hanuman on 24/10/19.
//  Copyright © 2019 Hanuman. All rights reserved.
//

import Foundation

struct Pager: Codable {
    let page, pages: Int?
    let perPage: String?
    let total: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, pages
        case perPage
        case total
    }
}
