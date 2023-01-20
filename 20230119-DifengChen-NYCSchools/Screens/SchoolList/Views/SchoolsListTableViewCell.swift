//
//  SchoolsListTableViewCell.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import UIKit

final class SchoolsListTableViewCell: UITableViewCell {

    // MARK: - User Interface

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.addArrangedSubview(nameLable)
        stackView.addArrangedSubview(numberOfStudentsLabel)
        stackView.addArrangedSubview(bottomSeparator)
        return stackView
    }()

    private lazy var nameLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        return label
    }()

    private lazy var numberOfStudentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        return label
    }()

    private lazy var bottomSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.setConstraints(height: 1)
        return view
    }()

    // MARK: - Properties

    private var school: School? {
        didSet {
            reloadUI()
        }
    }

    static var identifier: String {
        String(describing: type(of: self))
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUserInterface()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureUserInterface()
    }

    // MARK: - Functions

    private func configureUserInterface() {
        selectionStyle = .none
        accessoryType = .disclosureIndicator

        addSubview(stackView)

        stackView.setConstraints(leading: 0, top: 10, trailing: 0, bottom: -10)
        nameLable.setConstraints(leading: 10, trailing: -10)
        bottomSeparator.setConstraints(leading: 20, trailing: -20)

        layoutIfNeeded()
    }

    /// Configure the data for the cell
    /// - Parameter school: a school object to configure
    func configure(school: School) {
        self.school = school
    }

    /// Reload the UI to reflace the up-to-date data
    private func reloadUI() {
        nameLable.text = school?.school_name

        if let numberOfStudents = school?.total_students {
            numberOfStudentsLabel.text = "Number of Students: \(numberOfStudents)"
        }
    }
}
