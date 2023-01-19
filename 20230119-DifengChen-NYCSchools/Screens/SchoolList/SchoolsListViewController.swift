//
//  SchoolsListViewController.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import UIKit

final class SchoolsListViewController: UIViewController {

    // MARK: - UI

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(listTableView)
        return stackView
    }()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setConstraints(width: 250, height: 50)
        return imageView
    }()

    private lazy var listTableView: SchoolsListTableView = {
        let tableView = SchoolsListTableView()
        tableView.schoolsListDelegate = self
        return tableView
    }()

    // MARK: - Properties

    weak var coordinator: Coordinator?

    // MARK: - Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - Functions

    private func configureUI() {
        view.addSubview(containerStackView)
    }
}

// MARK: - SchoolsListDelegate+Extension

extension SchoolsListViewController: SchoolsListDelegate {
    func didSelect(school: School) {

    }
}
