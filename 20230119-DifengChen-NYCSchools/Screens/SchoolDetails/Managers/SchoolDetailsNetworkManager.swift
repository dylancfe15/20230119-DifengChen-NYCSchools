//
//  SchoolDetailsNetworkManager.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import Foundation

protocol SchoolDetailsNetworkManaging {

    func getSAT(_ dbn: String, completion: @escaping(_ sat: SAT?) -> Void)
}

final class SchoolDetailsNetworkManager: SchoolDetailsNetworkManaging {

    // MARK: - Functions

    /// Fetch the SAT data with the given database number
    /// - Parameters:
    ///   - dbn: the identifier of a school object
    ///   - completion: callback to return a SAT object if available
    func getSAT(_ dbn: String, completion: @escaping(_ sat: SAT?) -> Void) {
        guard var urlComponents = URLComponents(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json") else {
            return
        }

        urlComponents.queryItems = [URLQueryItem(name: "dbn", value: dbn)]

        guard let url = urlComponents.url else {
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let sats = try? JSONDecoder().decode([SAT].self, from: data) else {
                completion(nil)
                return
            }

            completion(sats.first)
        }

        task.resume()
    }
}
