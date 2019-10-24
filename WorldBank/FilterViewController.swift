//
//  FilterViewController.swift
//  WorldBank
//
//  Created by Hanuman on 24/10/19.
//  Copyright © 2019 Hanuman. All rights reserved.
//

import ActionSheetPicker_3_0
import Foundation
import UIKit

protocol FilterViewControllerDelegate: class {
    func applyFilter(with region: String?, country: String?, year: String?)
}

class FilterViewController: UIViewController, AlertDisplayer {
    weak var delegate: FilterViewControllerDelegate?

    @IBOutlet var regionButton: UIButton!
    @IBOutlet var countryButton: UIButton!
    @IBOutlet var yearButton: UIButton!
    
    var year: String?
    var country: String?
    var region: String?

    var yearArray: [Int] {
        var years: [Int] = []
        var year = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
        for _ in 1...30 {
            years.append(year)
            year -= 1
        }
        return years

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func apply(sender: UIButton) {
        delegate?.applyFilter(with: region, country: country, year: year)
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func region(sender: UIButton) {
    }

    @IBAction func country(sender: UIButton) {
    }

    @IBAction func year(sender: UIButton) {
        let yearPicker = ActionSheetStringPicker(title: "Year", rows: yearArray, initialSelection: 0, doneBlock: { [weak self] (_, _, value) in
            guard let strongSelf = self else { return }
            
            guard let yearInt = value as? Int else { return }
            strongSelf.year = String(format: "%d", yearInt)
            strongSelf.yearButton.titleLabel?.text = strongSelf.year
        }, cancel: { (_) in
            
        }, origin: sender)
        yearPicker!.show()
    }

}
