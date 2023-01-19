//
//  School.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import Foundation

struct School: Decodable {
    let dbn: String?
    let school_name: String?
    let overview_paragraph: String?
    let school_email: String?
    let phone_number: String?
    let website: String?
    let latitude: String?
    let longitude: String?
    let total_students: String?
    let location: String?
}
