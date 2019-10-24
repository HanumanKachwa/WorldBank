//
//  WorldBankGDPModel.swift
//  WorldBank
//
//  Created by Hanuman on 24/10/19.
//  Copyright © 2019 Hanuman. All rights reserved.
//

import Foundation

enum Result<T, U: Error> {
  case success(T)
  case failure(U)
}
