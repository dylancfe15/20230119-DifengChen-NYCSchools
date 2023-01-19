//
//  SchoolListViewModel.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import SwiftUI
import Combine

final class SchoolListViewModel {

    // MARK: - Properties

    private(set) var schools: [School] = []
    weak var coordinator: Coordinator?
    let schoolsPublisher = PassthroughSubject<[School], Never>()

    // MARK: - Functions

    /// Fetch a list of schools from the server
    /// - Parameter completion: returns a list of schools if available
    func getSchools() {
        // TODO: - Refactor URLs to configuration

        guard let url = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json") else {
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
            guard let data = data, let schools = try? JSONDecoder().decode([School].self, from: data) else {
                return
            }

            self?.schools = schools
            self?.schoolsPublisher.send(schools)
        }

        task.resume()
    }

    func presentSchoolDetails(for index: Int) {
        let school = schools[index]

        coordinator?.presentSchoolDetails(with: school)
    }
}
