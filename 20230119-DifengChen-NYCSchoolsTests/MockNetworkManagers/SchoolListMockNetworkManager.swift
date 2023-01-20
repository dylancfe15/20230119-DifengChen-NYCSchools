//
//  SchoolListMockNetworkManager.swift
//  20230119-DifengChen-NYCSchoolsTests
//
//  Created by Difeng Chen on 1/19/23.
//

import Foundation
@testable import _0230119_DifengChen_NYCSchools

final class SchoolListMockNetworkManager: SchoolListNetworkManaging {

    func getSchools(completion: @escaping ([School]?) -> Void) {
        guard let url = Bundle(for: SchoolListViewModelTests.self).url(forResource: "get_schools_response", withExtension: "json") else { return }

        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            let response = try JSONDecoder().decode([School].self, from: data)

            completion(response)
        } catch {
            completion(nil)
        }
    }
}
