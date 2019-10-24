//
//  MasterViewController.swift
//  WorldBank
//
//  Created by Hanuman on 23/10/19.
//  Copyright © 2019 Hanuman. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
  @IBOutlet var displayNameLabel: UILabel!
  @IBOutlet var gdpLabel: UILabel!
  @IBOutlet var indicatorView: UIActivityIndicatorView!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    configure(with: .none)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    indicatorView.hidesWhenStopped = true
    indicatorView.color = ColorPalette.RWGreen
  }
  
  func configure(with country: Country?) {
    if let country = country {
        
      displayNameLabel?.text = country.country?.value ?? ""
      gdpLabel?.text = country.value ?? "N/A"
      displayNameLabel.alpha = 1
      indicatorView.stopAnimating()
    } else {
      displayNameLabel.alpha = 0
      gdpLabel.alpha = 0
      indicatorView.startAnimating()
    }
  }
}
