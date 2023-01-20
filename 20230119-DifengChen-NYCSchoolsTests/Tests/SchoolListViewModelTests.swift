//
//  SchoolListViewModelTests.swift
//  20230119-DifengChen-NYCSchoolsTests
//
//  Created by Difeng Chen on 1/19/23.
//

import XCTest
import Combine
@testable import _0230119_DifengChen_NYCSchools

final class SchoolListViewModelTests: XCTestCase {

    private var viewModel: SchoolListViewModel!
    private var schoolsSubscription: AnyCancellable!
    private var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()

        viewModel = SchoolListViewModel()
        viewModel.networkManager = SchoolListMockNetworkManager()
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
        expectation = nil
        schoolsSubscription.cancel()
    }

    func testGetSchools_notNil() {
        expectation = expectation(description: "get_schools")

        schoolsSubscription = viewModel.schoolsPublisher.eraseToAnyPublisher().sink(receiveValue: { schools in

            XCTAssertNotNil(schools)

            self.expectation.fulfill()
        })

        viewModel.getSchools()

        waitForExpectations(timeout: 3)
    }

}
