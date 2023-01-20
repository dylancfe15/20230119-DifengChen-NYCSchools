//
//  ConfigurationsManager.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import Foundation

final class ConfigurationsManager {

    // MARK: - Properties

    private(set) var host: String?
    private(set) var getSchoolsURL: String?
    private(set) var getSATURL: String?

    static let shared = ConfigurationsManager()

    // MARK: - Initializers

    init() {
        host = property(for: .host) as? String

        if let host, let url = property(for: .getSchoolsURL) as? String {
            getSchoolsURL = "\(host)//\(url)"
        }

        if let host, let url = property(for: .getSATURL) as? String {
            getSATURL = "\(host)//\(url)"
        }
    }

    // MARK: - Functions

    private func property(for key: Property) -> Any? {
        Bundle.main.object(forInfoDictionaryKey: key.rawValue)
    }
}

// MARK: - ConfigurationsManager+Extension

extension ConfigurationsManager {
    enum Property: String {
        case host = "HOST"
        case getSchoolsURL = "GET SCHOOLS URL"
        case getSATURL = "GET SAT URL"
    }
}
