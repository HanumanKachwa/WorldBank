//
//  WorldBankGDPModel.swift
//  WorldBank
//
//  Created by Hanuman on 24/10/19.
//  Copyright © 2019 Hanuman. All rights reserved.
//

import Foundation

final class WorldBankClient {
    private lazy var baseURL: URL = {
        return URL(string: "http://api.worldbank.org")!
    }()
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchCountry(with request: CountryRequest, page: Int, completion: @escaping (Result<CountryData, DataResponseError>) -> Void) {
        // 1
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
        // 2
        let parameters = ["page": "\(page)"].merging(request.parameters, uniquingKeysWith: +)
        // 3
        let encodedURLRequest = urlRequest.encode(with: parameters)

        URLSession.shared.countryTask(with: encodedURLRequest, completionHandler: { (country, response, error) in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let country = country
                else {
                    completion(Result.failure(DataResponseError.network))
                    return
            }
            completion(Result.success(country))
        }).resume()
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
