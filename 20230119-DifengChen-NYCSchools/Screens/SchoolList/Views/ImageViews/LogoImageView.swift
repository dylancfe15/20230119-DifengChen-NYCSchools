//
//  LogoImageView.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import UIKit

final class LogoImageView: UIImageView {

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configure()
    }

    // MARK: -  Functions

    private func configure() {
        image = UIImage(named: "logo")

        translatesAutoresizingMaskIntoConstraints = false

        setConstraints(width: 250, height: 50)
    }
}
