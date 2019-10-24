//
//  WorldBankGDPModel.swift
//  WorldBank
//
//  Created by Hanuman on 24/10/19.
//  Copyright © 2019 Hanuman. All rights reserved.
//

import Foundation
import UIKit

protocol AlertDisplayer {
  func displayAlert(with title: String, message: String, actions: [UIAlertAction]?)
}

extension AlertDisplayer where Self: UIViewController {
  func displayAlert(with title: String, message: String, actions: [UIAlertAction]? = nil) {
    guard presentedViewController == nil else {
      return
    }
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    actions?.forEach { action in
      alertController.addAction(action)
    } 
    present(alertController, animated: true)
  }
}
