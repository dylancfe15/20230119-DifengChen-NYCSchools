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
        stackView.addArrangedSubview(loaderView)
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SchoolsListTableViewCell.self, forCellReuseIdentifier: SchoolsListTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()

    private lazy var loaderView = LoaderView(frame: .zero)

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

        containerStackView.setConstraints(leading: 0, top: 60, trailing: 0, bottom: 0)
        listTableView.setConstraints(leading: 0, trailing: 0)
        loaderView.setConstraints(leading: 0, trailing: 0)
    }

    private func configureSubscriptions() {
        schoolsSubscription = viewModel.schoolsPublisher
            .eraseToAnyPublisher()
            .debounce(for: .seconds(2), scheduler: RunLoop.main)
            .sink { [weak self] schools in
                guard let `self` = self else { return }

                guard let schools = schools else {
                    self.presentSerivceErrorAlert()
                    return
                }

                DispatchQueue.main.async {
                    self.listTableView.isHidden = schools.isEmpty
                    self.loaderView.isHidden = true

                    self.listTableView.reloadData()
                }
            }
    }

    private func presentSerivceErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Ops! Something went wrong while loading the data.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { [weak self] _ in
            self?.viewModel.getSchools()
        }))

        present(alert, animated: true, completion: nil)
    }
}

// MARK: - SchoolsListViewController+UITableViewDelegate

extension SchoolsListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.presentSchoolDetails(for: indexPath.row)
    }
}

// MARK: - SchoolsListViewController+UITableViewDataSource

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
