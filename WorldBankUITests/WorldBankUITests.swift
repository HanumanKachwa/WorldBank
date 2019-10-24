//
//  WorldBankUITests.swift
//  WorldBankUITests
//
//  Created by Hanuman on 23/10/19.
//  Copyright © 2019 Hanuman. All rights reserved.
//

import XCTest

class WorldBankUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testYearFilterView() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        app.navigationBars["WorldBank"].buttons["Filter"].tap()
        app.otherElements.containing(.navigationBar, identifier:"WorldBank.FilterView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).buttons["Select"].tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["2019"]/*[[".pickers.pickerWheels[\"2019\"]",".pickerWheels[\"2019\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.buttons["Apply"].tap()
    }

}
