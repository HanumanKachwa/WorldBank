//
//  WorldBankViewModel.swift
//  WorldBank
//
//  Created by Hanuman on 24/10/19.
//  Copyright © 2019 Hanuman. All rights reserved.
//

import Foundation

protocol WorldBankViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

final class WorldBankViewModel {
    private weak var delegate: WorldBankViewModelDelegate?
    
    private var countries: [Country] = []
    private var currentPage = 1
    private var total = 0
    private var isFetchInProgress = false
    
    let client = WorldBankClient()
    var request: CountryRequest
    
    var year: String? {
        didSet {
            resetData()
        }
    }
    var country: String? {
        didSet {
            resetData()
        }
    }
    var region: String? {
        didSet {
            resetData()
        }
    }

    func resetData() {
        currentPage = 1
        total = 0
        countries = []
    }
    
    init(delegate: WorldBankViewModelDelegate) {
        self.request = CountryRequest.request(with: nil, country: nil, year: "2018")
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
        return countries.count
    }
    
    func moderator(at index: Int) -> Country {
        return countries[index]
    }
    
    func fetchCountry() {
        // 1
        guard !isFetchInProgress else {
            return
        }
        
        // 2
        isFetchInProgress = true
        
        self.request = CountryRequest.request(with: region, country: country, year: year)

        client.fetchCountry(with: request, page: currentPage) { result in
            switch result {
            // 3
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: error.reason)
                }
            // 4
            case .success(let response):
                DispatchQueue.main.async {
                    // 1
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    // 2
                    // If you want to get elements from this Array, you might do something like below
                    var receivedPage = 0
                    var receivedCountries = [Country]()
                    response.forEach({ (element) in
                        if case .pager(let pager) = element {
                            receivedPage = pager.page ?? 0
                            self.total = pager.total ?? 0
                        }
                        if case .countryArray(let country) = element {
                            receivedCountries = country
                            self.countries.append(contentsOf: country)
                        }
                    })
                    
                    // 3
                    if receivedPage > 1 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: receivedCountries)
                        self.delegate?.onFetchCompleted(with: indexPathsToReload)
                    } else {
                        self.delegate?.onFetchCompleted(with: .none)
                    }
                }
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newCountries: [Country]) -> [IndexPath] {
        let startIndex = countries.count - newCountries.count
        let endIndex = startIndex + newCountries.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
}
