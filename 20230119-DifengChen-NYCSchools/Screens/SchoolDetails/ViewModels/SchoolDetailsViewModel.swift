//
//  SchoolDetailsViewModel.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import UIKit

final class SchoolDetailsViewModel: ObservableObject {

    // MARK: - Properties

    @Published var sat: SAT?

    var networkManager: SchoolDetailsNetworkManaging = SchoolDetailsNetworkManager()

    // MARK: - Functions

    /// Fetch the SAT data with the given database number
    /// - Parameter dbn: the identifier of a school object
    func getSAT(_ dbn: String?) {
        guard let dbn = dbn else { return }

        networkManager.getSAT(dbn) { [weak self] sat in
            DispatchQueue.main.async {
                self?.sat = sat
            }
        }
    }

    /// Open Safari with the given URL
    /// - Parameter website: an URL to be open on Safari
    func open(website: String) {
        if let url = URL(string: "https://\(website)") {
            UIApplication.shared.open(url)
        }
    }

    /// Open Mail with the given email
    /// - Parameters:
    ///   - email: an email of the receipient to prefill when opening the Mail app
    ///   - completion: handler to return the status of opening the url
    func open(email: String, completion: @escaping(_ succeed: Bool) -> Void) {
        if let url = URL(string: "mailto:\(email)"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            completion(false)
        }
    }

    /// Make a phone call to the given phone number
    /// - Parameters:
    ///   - phoneNumber: a phone number to be called
    ///   - completion: handler to return the status of opening the url
    func open(phoneNumber: String, completion: @escaping(_ succeed: Bool) -> Void) {
        if let url = URL(string: "tel://\(phoneNumber)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            completion(false)
        }
    }
}
