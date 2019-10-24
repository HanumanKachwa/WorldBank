//
//  Country.swift
//  WorldBank
//
//  Created by Hanuman on 24/10/19.
//  Copyright © 2019 Hanuman. All rights reserved.
//

import Foundation

// MARK: - Country
struct Country: Codable {
//    let id, iso2Code, name: String?
//    let region, adminregion, incomeLevel, lendingType: Adminregion?
//    let capitalCity, longitude, latitude: String?
    
    let indicator, country: CountryClass?
    let value: String?
    let decimal, date: String?
}

struct CountryClass: Codable {
    let id: String?
    let value: String?
}

// MARK: - Adminregion
struct Adminregion: Codable {
    let id, iso2Code, value: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case iso2Code
        case value
    }
}
