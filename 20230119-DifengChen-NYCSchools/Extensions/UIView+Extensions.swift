//
//  UIView+Extensions.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import UIKit

extension UIView {

    /// Set constraints for the size
    /// - Parameters:
    ///   - width: the constant of the width to be set
    ///   - height:the constant of the height to be set
    /// - Returns: The activated size constraints
    func setConstraints(width: CGFloat? = nil, height: CGFloat? = nil) {
        var constraints: [NSLayoutConstraint] = []

        if let width = width {
            constraints.append(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width))
        }

        if let height = height {
            constraints.append(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height))
        }

        NSLayoutConstraint.activate(constraints)
    }

    /// Set constraints for margin
    /// - Parameters:
    ///   - leading: the constant of the leading edge to be set
    ///   - top: the constant of the top edge to be set
    ///   - trailing: the constant of the trailing edge to be set
    ///   - bottom: the constant of the bottom edge to be set
    func setConstraints(leading: CGFloat? = nil, top: CGFloat? = nil, trailing: CGFloat? = nil, bottom: CGFloat? = nil) {
        var constraints: [NSLayoutConstraint] = []

        if let leading = leading {
            constraints.append(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leading, multiplier: 1, constant: leading))
        }

        if let top = top {
            constraints.append(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: top))
        }

        if let trailing = trailing {
            constraints.append(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superview, attribute: .trailing, multiplier: 1, constant: trailing))
        }

        if let bottom = bottom {
            constraints.append(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1, constant: bottom))
        }

        NSLayoutConstraint.activate(constraints)
    }

    /// Set the centerX constraint to senterXof the superview
    func centerX() {
        let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1, constant: 0)

        NSLayoutConstraint.activate([constraint])
    }

    /// Set the centerY constraint to senterY of the superview
    func centerY() {
        let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1, constant: 0)

        NSLayoutConstraint.activate([constraint])
    }

    /// /// Set the centerY and centerX constraints to senter of the superview
    func center() {
        centerX()
        centerY()
    }
}
