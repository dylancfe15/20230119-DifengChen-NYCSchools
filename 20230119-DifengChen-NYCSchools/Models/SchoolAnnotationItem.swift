//
//  SchoolAnnotationItem.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import Foundation
import CoreLocation

struct SchoolAnnotationItem: Identifiable {
    let id: String
    let coordinate: CLLocationCoordinate2D
}
