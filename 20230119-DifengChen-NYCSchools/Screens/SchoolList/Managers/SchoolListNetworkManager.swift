//
//  SchoolListNetworkManager.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import Foundation

protocol SchoolListNetworkManaging {

    func getSchools(completion: @escaping(_ schools: [School]?) -> Void)
}

final class SchoolListNetworkManager: SchoolListNetworkManaging {

    /// Fetch a list of schools from the server
    /// - Parameter completion: returns a list of schools if available
    func getSchools(completion: @escaping(_ schools: [School]?) -> Void) {
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json") else {
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data,
                    let schools = try? JSONDecoder().decode([School].self, from: data) else {
                completion(nil)
                return
            }

            completion(schools)
        }

        task.resume()
    }
}
