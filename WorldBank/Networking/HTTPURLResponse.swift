//
//  WorldBankGDPModel.swift
//  WorldBank
//
//  Created by Hanuman on 24/10/19.
//  Copyright © 2019 Hanuman. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
  var hasSuccessStatusCode: Bool {
    return 200...299 ~= statusCode
  }
}
