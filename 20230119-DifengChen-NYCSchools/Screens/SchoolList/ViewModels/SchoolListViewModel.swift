//
//  SchoolListViewModel.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import SwiftUI

final class SchoolListViewModel {

    // MARK: - Properties

    private(set) var schools: [School] = []
    weak var coordinator: Coordinator?

    // MARK: - Functions

    func presentSchoolDetails(for index: Int) {
        let school = schools[index]
        let detailsView = UIHostingController(rootView: SchoolDetailsView(school: school))

        coordinator?.navigationController.present(detailsView, animated: true, completion: nil)
    }
}
