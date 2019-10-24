//
//  WorldBankGDPModel.swift
//  WorldBank
//
//  Created by Hanuman on 24/10/19.
//  Copyright © 2019 Hanuman. All rights reserved.
//

import Foundation

enum PagedCountryResponse: Codable {
    case pager(Pager)
    case countryArray([Country])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Country].self) {
            self = .countryArray(x)
            return
        }
        if let x = try? container.decode(Pager.self) {
            self = .pager(x)
            return
        }
        throw DecodingError.typeMismatch(PagedCountryResponse.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PagedCountryResponse"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .pager(let x):
            try container.encode(x)
        case .countryArray(let x):
            try container.encode(x)
        }
    }
}

typealias CountryData = [PagedCountryResponse]



