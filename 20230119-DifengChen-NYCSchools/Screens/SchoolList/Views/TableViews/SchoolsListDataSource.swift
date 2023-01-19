//
//  SchoolsListDataSource.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import UIKit

final class SchoolsListDataSource: NSObject, UITableViewDataSource {

    // MARK: - Properties

    private var tableView: SchoolsListTableView?
    private(set) var schools: [School] = []

    // MARK: - Initializers

    convenience init(tableView: SchoolsListTableView) {
        self.init()

        tableView.register(SchoolsListTableViewCell.self, forCellReuseIdentifier: SchoolsListTableViewCell.identifier)

        self.tableView = tableView
    }

    // MARK: - UITableViewDataSource Functions

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        schools.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let school = schools[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SchoolsListTableViewCell.identifier, for: indexPath) as? SchoolsListTableViewCell

        cell?.configure(school: school)

        return cell ?? UITableViewCell()
    }

    // MARK: - General Functions

    /// Reload tableView with the given list of schools
    /// - Parameter schools: a list of schools to reload
    func reload(with schools: [School]) {
        self.schools = schools

        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
}
