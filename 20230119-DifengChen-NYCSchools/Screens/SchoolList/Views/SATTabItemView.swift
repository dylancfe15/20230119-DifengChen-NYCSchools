//
//  SATTabItemView.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import SwiftUI

struct SATTabItemView: View {

    // MARK: - Properties

    let title: String
    let score: String

    // MARK: - Views

    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)

            Text(score)
                .font(.largeTitle)
                .fontWeight(.heavy)

            Text("(average)")
                .font(.body)
                .foregroundColor(.gray)
        }
            .frame(width: 300, height: 200)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
    }
}
