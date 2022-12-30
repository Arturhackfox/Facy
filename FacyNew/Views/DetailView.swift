//
//  DetailView.swift
//  FacyNew
//
//  Created by Arthur Sh on 29.12.2022.
//

import SwiftUI

struct DetailView: View {
    var person: Person
    var body: some View {
        VStack{
            Image(uiImage: person.image ?? UIImage(systemName: "")!)
                .resizable()
                .scaledToFit()
                .padding()
            
            Text(person.name)
                .font(.title)
                .padding()
            
            
            
            Spacer()

        }
    }
}

