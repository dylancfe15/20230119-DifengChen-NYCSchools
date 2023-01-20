//
//  SchoolDetailsMockNetworkManager.swift
//  20230119-DifengChen-NYCSchoolsTests
//
//  Created by Difeng Chen on 1/19/23.
//

import Foundation
@testable import _0230119_DifengChen_NYCSchools

final class SchoolDetailsMockNetworkManager: SchoolDetailsNetworkManaging {

    func getSAT(_ dbn: String, completion: @escaping(_ sat: SAT?) -> Void) {
        guard let url = Bundle(for: SchoolDetailsViewModelTests.self).url(forResource: "get_sat_response", withExtension: "json") else { return }

        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            let response = try JSONDecoder().decode(SAT.self, from: data)

            completion(response)
        } catch {
            completion(nil)
        }
    }
}
