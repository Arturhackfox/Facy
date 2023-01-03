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
        VStack(spacing: 0){
            ZStack{
                Image(uiImage: person.image ?? UIImage(systemName: "")!)
                    .resizable()
                    .scaledToFit()
                    .padding()
          
            }
            HStack{
                Text(person.name)
                    .font(.title3)
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding()
                
                Text("\(person.age) years old")
                    .font(.title3)
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text("from \(person.country)")
                    .font(.title3)
                    .padding()
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Spacer()
            }
            
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

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(person: Person(id: UUID(), name: "max", image: UIImage(systemName: "person.fill")!, long: 20, lat: 30, country: "Ukraine", age: "21"))
            .environmentObject(ViewModelLogic())
    }
}
