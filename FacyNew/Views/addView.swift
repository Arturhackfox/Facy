//
//  addView.swift
//  FacyNew
//
//  Created by Arthur Sh on 29.12.2022.
//

import SwiftUI
import MapKit

struct AddView: View {
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    @EnvironmentObject var vm: ViewModelLogic
    @StateObject var model = ViewModel()

    @Environment(\.dismiss) var dismiss
    
    var locationFetcher = LocationFetcher()

    var body: some View {
        Form{
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.gray)
                    .opacity(model.imageDidLoad ? 0 : 100)
                    .frame(width: 370, height: 370)
                Text("TAP TO SELECT IMAGE")
                    .font(.title)
                    .opacity(model.imageDidLoad ? 0 : 100)
                    .foregroundColor(.white)
                model.image?
                    .resizable()
                    .scaledToFit()
                
            }
            .onTapGesture {
                model.imageDidLoad = true
                model.isPhotoPickerShowing = true
            }
                Section{
                    HStack {
                        Text("Name: ")
                        
                        TextField("Enter person's name", text: $model.name)
                            .textInputAutocapitalization(.never)
                    }
                }
                
                Section{
                    HStack {
                        Text("Age: ")
                        
                        TextField("Enter person's age", text: $model.age)
                    }
                }
                
                Section{
                    HStack {
                        Text("Contry name")
                        
                        TextField("Enter country where you met", text: $model.country)
                    }
                }
                Section("Choose Point on map"){
                    ZStack{
                        Map(coordinateRegion: $mapRegion, annotationItems: vm.people ) { location in
                            MapAnnotation(coordinate: location.coordinates) {
                                VStack{
                                    Circle()
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        Circle()
                            .foregroundColor(.blue.opacity(0.6))
                            .frame(width: 10, height: 10)
                }
                .frame(width: 400, height: 300)
            }
       
        }
        .navigationTitle("Add")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            Button("Save") {
                let new = Person(id: UUID(), name: model.name, image: model.inputImage ?? UIImage(systemName: "camera.circle")!, long: mapRegion.center.longitude, lat: mapRegion.center.latitude, country: model.country)
                vm.addPerson(person: new)
                dismiss()
            }
        }
        .sheet(isPresented: $model.isPhotoPickerShowing) {
            imagePicker(image: $model.inputImage)
        }
        .onChange(of: model.inputImage) { _ in model.loadImage()}
       

    }

}
struct addView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(ViewModelLogic())
    }
}
