//
//  SchoolsListContainerStackView.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import UIKit

final class SchoolsListContainerStackView: UIStackView {

    // MARK: -  Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)

        configure()
    }

    // MARK: - Functions

    private func configure() {
        axis = .vertical
        alignment = .center
        spacing = 8

        translatesAutoresizingMaskIntoConstraints = false
    }
}
