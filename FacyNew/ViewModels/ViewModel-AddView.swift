//
//  ViewModel-AddView.swift
//  FacyNew
//
//  Created by Arthur Sh on 29.12.2022.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

extension AddView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var name = ""
        @Published var age = ""
        @Published var info = ""
        @Published var longti = 0.0
        @Published var latit = 0.0
        
//        @Published  var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        
        @Published  var selectedPlace: Person?
        
        
        @Published var inputImage: UIImage?
        @Published var image: Image?
        @Published  var imageDidLoad = false
        
        @Published var isPhotoPickerShowing = false
        
        func loadImage() {
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
        }
    }
}
