//
//  SchoolDetailsView.swift
//  20230119-DifengChen-NYCSchools
//
//  Created by Difeng Chen on 1/19/23.
//

import SwiftUI
import MapKit

struct SchoolDetailsView: View {

    // MARK: - Properties

    @State private var region = MKCoordinateRegion()
    @State private var isMailAlertPresented = false
    @State private var isPhoneAlertPresented = false
    @StateObject private var viewModel = SchoolDetailsViewModel()

    let school: School

    private var coordinate: CLLocationCoordinate2D? {
        if let latitudeString = school.latitude,
           let latitude = Double(latitudeString),
           let longitudeString = school.longitude,
           let longitude = Double(longitudeString) {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            return nil
        }
    }

    // MARK: - Initializers

    init(school: School) {
        self.school = school

        if let coordinate {
            region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }

    // MARK: - Views

    var body: some View {
        ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    nameView
                    websiteView
                    overviewParagraphView
                    contactsView
                    locationView
                    mapView
                    satView
                }
                    .padding()
        }
    }

    private var nameView: some View {
        VStack {
            if let schoolName = school.school_name {
                Text(schoolName)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding()
            }
        }
            .padding(.top, 50)
    }

    private var websiteView: some View {
        VStack {
            if let website = school.website {
                Button {
                    viewModel.open(website: website)
                } label: {
                    Text(website)
                        .font(.body)
                        .foregroundColor(.brown)
                }
            }
        }
    }

    private var overviewParagraphView: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let overviewParagraph = school.overview_paragraph {
                SectionTitleText("Overview:")

                Text(overviewParagraph)
                    .font(.body)
                    .foregroundColor(.gray)
            }
        }
    }

    private var contactsView: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionTitleText("Contacts:")

            if let email = school.school_email {
                Button {
                    viewModel.open(email: email) {
                        isMailAlertPresented = !$0
                    }
                } label: {
                    HStack {
                        Text("Email: \(email)")
                            .foregroundColor(.brown)
                    }
                        .alert(isPresented: $isMailAlertPresented) {
                            Alert(title: Text("Unable to open Mail."), message: Text("Please make sure that you have installed the Mail app properly on your device."), dismissButton: .cancel())
                        }
                }
            }

            if let phoneNumber = school.phone_number {
                Button {
                    viewModel.open(phoneNumber: phoneNumber) {
                        isPhoneAlertPresented = !$0
                    }
                } label: {
                    HStack {
                        Text("Phone Number: \(phoneNumber)")
                            .foregroundColor(.brown)
                    }
                        .alert(isPresented: $isPhoneAlertPresented) {
                            Alert(title: Text("Unable to make a phone call."), message: Text("Something went wrong when calling the number, please double check the number and try again."), dismissButton: .cancel())
                        }
                }

            }
        }
    }

    private var locationView: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let location = school.location {
                SectionTitleText("Location:")

                Text(location)
                    .font(.body)
                    .foregroundColor(.gray)
            }
        }
    }

    private var mapView: some View {
        VStack {
            if let coordinate = coordinate {
                Map(coordinateRegion: $region, annotationItems: [SchoolAnnotationItem(id: school.dbn ?? "", coordinate: coordinate)]) { item in
                    MapAnnotation(coordinate: coordinate) {
                        VStack {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.blue)
                                .frame(width: 40, height: 40)
                        }
                            .frame(width: 50, height: 50)
                            .background(.white)
                            .clipShape (
                                Circle()
                            )
                            .shadow(radius: 10)
                    }
                }
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }

    private var satView: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionTitleText("SAT:")

            if let sat = viewModel.sat {
                TabView {
                    if let readingScore = sat.sat_critical_reading_avg_score {
                        SATTabItemView(title: "Critical Reading Score:", score: readingScore)
                    }

                    if let mathScore = sat.sat_math_avg_score {
                        SATTabItemView(title: "Math Score:", score: mathScore)
                    }

                    if let writingScore = sat.sat_writing_avg_score {
                        SATTabItemView(title: "Writing Score:", score: writingScore)
                    }
                }
                    .frame(height: 250)
                    .tabViewStyle(PageTabViewStyle())
            } else {
                Text("No available")
            }
        }
            .onAppear {
                viewModel.getSAT(school.dbn)
            }
    }
}
