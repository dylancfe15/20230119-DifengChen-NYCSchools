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
    let schoolsPublisher = PassthroughSubject<[School]?, Never>()
    var networkManager: SchoolListNetworkManaging = SchoolListNetworkManager()

    // MARK: - Functions

    /// Fetch a list of schools from the server
    func getSchools() {
        networkManager.getSchools { [weak self] schools in
            self?.schools = schools ?? []
            self?.schoolsPublisher.send(schools)
        }
    }

    func presentSchoolDetails(for index: Int) {
        coordinator?.presentSchoolDetails(with: schools[index])
    }
}
