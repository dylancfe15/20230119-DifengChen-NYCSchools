//
//  SectionTitleText.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import SwiftUI

struct SectionTitleText: View {

    // MARK: -  Properties

    let text: String

    // MARK: - Initializers

    init(_ text: String) {
        self.text = text
    }

    // MARK: - Views

    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
    }
}
