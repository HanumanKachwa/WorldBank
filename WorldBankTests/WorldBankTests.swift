//
//  WorldBankTests.swift
//  WorldBankTests
//
//  Created by Hanuman on 23/10/19.
//  Copyright © 2019 Hanuman. All rights reserved.
//

@testable import WorldBank
import XCTest

class WorldBankTests: XCTestCase {
    var viewModel: WorldBankViewModel!
    var expectation: XCTestExpectation?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = WorldBankViewModel(delegate: self)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testResetFilters() {
        viewModel.year = "2018"
        XCTAssert(viewModel.currentPage == 1, "Current page should reset while applying filters")
        
        viewModel.country = "AU"
        XCTAssert(viewModel.currentPage == 1, "Current page should reset while applying filters")
        
        viewModel.region = "1A"
        XCTAssert(viewModel.currentPage == 1, "Current page should reset while applying filters")

    }
    
    func testMultipleFetch() {
        viewModel.year = "2018"
        XCTAssert(viewModel.isFetchInProgress == false, "Fetch not started")
        expectation = XCTestExpectation(description: "Download worldbank GDP")
        viewModel.fetchCountry()
        XCTAssert(viewModel.isFetchInProgress == true, "Fetch started")
        viewModel.fetchCountry()
        XCTAssert(viewModel.isFetchInProgress == true, "Fetch started and should return")
        if let expectation = expectation {
            wait(for: [expectation], timeout: 10.0)
            XCTAssert(viewModel.isFetchInProgress == false, "Fetch completed")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

extension WorldBankTests: WorldBankViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        expectation?.fulfill()
    }
    
    func onFetchFailed(with reason: String) {
        expectation?.fulfill()
    }
}

