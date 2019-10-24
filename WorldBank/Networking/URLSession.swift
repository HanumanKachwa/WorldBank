//
//  URLSession.swift
//  WorldBank
//
//  Created by Hanuman on 24/10/19.
//  Copyright © 2019 Hanuman. All rights reserved.
//

import Foundation

extension URLSession {
    fileprivate func codableTask<T: Codable>(with urlRequest: URLRequest, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func countryTask(with urlRequest: URLRequest, completionHandler: @escaping (CountryData?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: urlRequest, completionHandler: completionHandler)
    }
}
