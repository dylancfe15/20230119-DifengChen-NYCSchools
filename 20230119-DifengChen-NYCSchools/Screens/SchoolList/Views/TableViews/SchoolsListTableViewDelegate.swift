//
//  SchoolsListTableViewDelegate.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import UIKit

final class SchoolsListTableViewDelegate: NSObject, UITableViewDelegate {

    // MARK: -  Properties

    private var dataSource: SchoolsListDataSource?

    // MARK: - Initializers

    convenience init(dataSource: SchoolsListDataSource) {
        self.init()

        self.dataSource = dataSource
    }

    // MARK: - UITableViewDelegate Functions

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tableView = tableView as? SchoolsListTableView,
            let dataSource = dataSource else {
            return
        }

        let school = dataSource.schools[indexPath.row]

        tableView.schoolsListDelegate?.didSelect(school: school)
    }
}
