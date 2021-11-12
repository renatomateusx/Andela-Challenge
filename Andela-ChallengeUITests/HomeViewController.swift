//
//  Andela_ChallengeUITests.swift
//  Andela-ChallengeUITests
//
//  Created by Renato Mateus on 11/11/21.
//

import XCTest

class HomeViewControllerUITest: XCTestCase {

    func testTableResults() {
        let app = XCUIApplication()
        app.launch()
        _ = app.collectionViews.firstMatch.waitForExistence(timeout: 15)
        let cellCount = app.collectionViews.cells.count
        XCTAssertTrue(cellCount > 0)
    }
    
    func testTapTableViewCell() {
        let app = XCUIApplication()
        app.launch()
        let cell = app.collectionViews.cells.element(boundBy: 2)
        XCTAssertTrue(cell.exists)
        cell.tap()
    }
    
    func testSwipeDownNavigation() {
        let app = XCUIApplication()
        app.launch()
        let cell = app.collectionViews.cells.element(boundBy: 2)
        XCTAssertTrue(cell.exists)
        cell.tap()
        app.swipeDown()
    }
    
    func testLoadMore() {
        let app = XCUIApplication()
        app.launch()
        _ = app.collectionViews.firstMatch.waitForExistence(timeout: 5)
        let firstCount = app.collectionViews.staticTexts.count
        for _ in 1...25 {
            app.collectionViews.firstMatch.swipeUp()
        }
        var afterCount = app.collectionViews.staticTexts.count
        afterCount += 5
        XCTAssertTrue(afterCount > firstCount)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
