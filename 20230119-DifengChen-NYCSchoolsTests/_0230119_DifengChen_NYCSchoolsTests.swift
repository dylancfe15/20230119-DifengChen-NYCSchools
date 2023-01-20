//
//  _0230119_DifengChen_NYCSchoolsTests.swift
//  20230119-DifengChen-NYCSchoolsTests
//
//  Created by Difeng Chen on 1/19/23.
//

import XCTest
import Combine
@testable import _0230119_DifengChen_NYCSchools

final class SchoolDetailsViewModelTests: XCTestCase {

    private var viewModel: SchoolDetailsViewModel!
    private var detailsSubscription: AnyCancellable!
    private var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()

        viewModel = SchoolDetailsViewModel()
        viewModel.networkManager = SchoolDetailsMockNetworkManager()
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
        expectation = nil
        detailsSubscription.cancel()
    }

    func testGetSAT_notNil() {
        expectation = expectation(description: "get_sat")

        detailsSubscription = viewModel.sat.publisher.eraseToAnyPublisher().sink(receiveValue: { sat in
            XCTAssertNotNil(sat.sat_critical_reading_avg_score)
            XCTAssertNotNil(sat.sat_math_avg_score)
            XCTAssertNotNil(sat.sat_writing_avg_score)

            self.expectation.fulfill()
        })

        viewModel.getSAT("abc")

        waitForExpectations(timeout: 3)
    }
}
