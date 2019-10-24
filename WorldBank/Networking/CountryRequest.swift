//
//  WorldBankGDPModel.swift
//  WorldBank
//
//  Created by Hanuman on 24/10/19.
//  Copyright © 2019 Hanuman. All rights reserved.
//

import Foundation

struct CountryRequest {
    var region: String?
    var country: String?

    var path: String {
        if let country = country {
            return "country/\(country)/indicator/NY.GDP.MKTP.CD"
        }
        if let region = region {
            return "country/\(region)/indicator/NY.GDP.MKTP.CD"
        }
        return "country/all/indicator/NY.GDP.MKTP.CD"
    }
    
    let parameters: Parameters
    private init(parameters: Parameters) {
        self.parameters = parameters
    }
}

extension CountryRequest {
    static func request(with region: String?, country: String?, year: String?) -> CountryRequest {
        var defaultParameters = ["format": "json"]
        let currentYear = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
        defaultParameters["date"] = year ?? "\(currentYear - 1)"
        var request = CountryRequest(parameters: defaultParameters)
        request.country = country
        request.region = region
        return request
    }
}
