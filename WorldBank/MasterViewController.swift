//
//  MasterViewController.swift
//  WorldBank
//
//  Created by Hanuman on 23/10/19.
//  Copyright © 2019 Hanuman. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, AlertDisplayer {
    private enum SegueIdentifiers {
        static let filter = "FilterSegue"
    }

    private enum CellIdentifiers {
        static let list = "List"
    }

    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!

    private var viewModel: WorldBankViewModel!

    private var shouldShowLoadingCell = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorView.color = ColorPalette.RWGreen
        indicatorView.startAnimating()
        
        tableView.isHidden = true
        tableView.separatorColor = ColorPalette.RWGreen
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.estimatedRowHeight = 124.0
        tableView.rowHeight = UITableView.automaticDimension

        viewModel = WorldBankViewModel(delegate: self)
        
        viewModel.fetchCountry()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.filter {
            if let vc = segue.destination as? FilterViewController {
                vc.delegate = self
            }
        }
    }
}

extension MasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.list, for: indexPath) as! CountryTableViewCell
        // 2
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else {
            cell.configure(with: viewModel.moderator(at: indexPath.row))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MasterViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchCountry()
        }
    }
}

extension MasterViewController: FilterViewControllerDelegate {
    func applyFilter(with region: String?, country: String?, year: String?) {
        viewModel.year = year
        viewModel.country = country
        viewModel.region = region
        viewModel.fetchCountry()
    }
}

extension MasterViewController: WorldBankViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        // 1
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            indicatorView.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            return
        }
        // 2
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    func onFetchFailed(with reason: String) {
        indicatorView.stopAnimating()
        
        let title = "Warning".localizedString
        let action = UIAlertAction(title: "OK".localizedString, style: .default)
        displayAlert(with: title , message: reason, actions: [action])
    }
}

private extension MasterViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}


