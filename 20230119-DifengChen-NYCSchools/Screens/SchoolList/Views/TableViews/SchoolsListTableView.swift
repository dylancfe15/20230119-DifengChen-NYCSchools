//
//  SchoolsListTableView.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import UIKit

protocol SchoolsListDelegate: AnyObject {

    func didSelect(school: School)
}

final class SchoolsListTableView: UITableView {

    // MARK: - Properties

    private lazy var tableViewDataSource = SchoolsListDataSource(tableView: self)
    private lazy var tableViewDelegate = SchoolsListTableViewDelegate(dataSource: tableViewDataSource)

    weak var schoolsListDelegate: SchoolsListDelegate?

    // MARK: - Initializers

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configure()
    }

    // MARK: - Functions

    private func configure() {
        dataSource = tableViewDataSource
        delegate = tableViewDelegate

        separatorStyle = .none
        translatesAutoresizingMaskIntoConstraints = false
    }

    /// reload tableView with the given list of schools
    /// - Parameter schools: a list of schools to reload
    func reload(with schools: [School]) {
        tableViewDataSource.reload(with: schools)
    }
}
