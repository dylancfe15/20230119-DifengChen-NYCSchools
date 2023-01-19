//
//  _0230119_DifengChen_NYCSchoolsUITestsLaunchTests.swift
//  20230119-DifengChen-NYCSchoolsUITests
//
//  Created by Difeng Chen on 1/19/23.
//

import XCTest

final class _0230119_DifengChen_NYCSchoolsUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
