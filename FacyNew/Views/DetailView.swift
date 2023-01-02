//
//  DetailView.swift
//  FacyNew
//
//  Created by Arthur Sh on 29.12.2022.
//

import SwiftUI
import MapKit
struct DetailView: View {
    @EnvironmentObject var vm: ViewModelLogic
    
    var person: Person
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    
    var body: some View {
        VStack{
            Image(uiImage: person.image ?? UIImage(systemName: "")!)
                .resizable()
                .scaledToFit()
                .padding()
            
            Text(person.name)
                .font(.title)
                .padding()
            
            ZStack{
                Map(coordinateRegion: $mapRegion, annotationItems: vm.people ) { person in
                    MapAnnotation(coordinate: person.coordinates) {
                            VStack(spacing: 0){
                                Circle()
                                    .foregroundColor(.red)
                                    .padding(.bottom, 2)
                                    Text(person.name)
                                        .fixedSize()
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                            }
                    }
                }
             
            }
            Spacer()

        }
        .onAppear(perform: update)
       
        
    }
    
    func update() {
        mapRegion = MKCoordinateRegion(center: person.coordinates, span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    }
}

