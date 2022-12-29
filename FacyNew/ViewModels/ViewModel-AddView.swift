//
//  ViewModel-AddView.swift
//  FacyNew
//
//  Created by Arthur Sh on 29.12.2022.
//

import Foundation
import SwiftUI

extension AddView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var name = ""
        @Published var age = ""
        @Published var info = ""
        
        
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
