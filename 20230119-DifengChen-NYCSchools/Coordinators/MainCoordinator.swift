//
//  MainCoordinator.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import SwiftUI

final class MainCoordinator: Coordinator {

    // MARK: - Properties

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    // MARK: - Initializers

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Functions

    func start(with viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: false)
    }

    func presentSchoolDetails(with school: School) {
        let detailsView = UIHostingController(rootView: SchoolDetailsView(school: school))

        navigationController.present(detailsView, animated: true, completion: nil)
    }
}
