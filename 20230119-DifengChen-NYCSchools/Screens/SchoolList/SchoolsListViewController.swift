//
//  SchoolsListViewController.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import UIKit
import Combine

final class SchoolsListViewController: UIViewController {

    // MARK: - User Interface

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
        imageView.contentMode = .scaleAspectFit
        imageView.setConstraints(width: 250, height: 50)
        return imageView
    }()

    private lazy var listTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SchoolsListTableViewCell.self, forCellReuseIdentifier: SchoolsListTableViewCell.identifier)
        return tableView
    }()

    // MARK: - Properties

    private(set) lazy var viewModel = SchoolListViewModel()
    private var schoolsSubscription: AnyCancellable?

    // MARK: - Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUserInterface()
        configureSubscriptions()

        viewModel.getSchools()
    }

    deinit {
        schoolsSubscription?.cancel()
    }

    // MARK: - Functions

    private func configureUserInterface() {
        view.backgroundColor = .white

        view.addSubview(containerStackView)

        containerStackView.setConstraints(leading: 0, top: 50, trailing: 0, bottom: 0)
        listTableView.setConstraints(leading: 0, trailing: 0)
    }

    private func configureSubscriptions() {
        schoolsSubscription = viewModel.schoolsPublisher.eraseToAnyPublisher().sink { [weak self] schools in
            guard let `self` = self else { return }

            DispatchQueue.main.async {
                self.listTableView.isHidden = schools?.isEmpty ?? true
                self.listTableView.reloadData()
            }
        }

    }
}

// MARK: - UITableViewDelegate+Extension

extension SchoolsListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.presentSchoolDetails(for: indexPath.row)
    }
}

// MARK: - UITableViewDataSource+Extension

extension SchoolsListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.schools.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let school = viewModel.schools[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SchoolsListTableViewCell.identifier, for: indexPath) as? SchoolsListTableViewCell

        cell?.configure(school: school)

        return cell ?? UITableViewCell()
    }
}
