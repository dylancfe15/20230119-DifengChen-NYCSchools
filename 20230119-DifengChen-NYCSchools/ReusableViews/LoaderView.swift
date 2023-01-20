//
//  LoaderView.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import UIKit

final class LoaderView: UIImageView {

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUserInterface()
        startAnimation()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureUserInterface()
        startAnimation()
    }

    // MARK: -  Functions

    private func configureUserInterface() {
        image = UIImage(named: "loader")

        contentMode = .scaleToFill

        translatesAutoresizingMaskIntoConstraints = false
    }

    private func startAnimation() {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.fromValue = 0.3
        animation.toValue = 0.7
        animation.duration = 0.5
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.autoreverses = true

        layer.add(animation, forKey: nil)
    }
}
