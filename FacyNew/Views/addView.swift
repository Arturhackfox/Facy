//
//  addView.swift
//  FacyNew
//
//  Created by Arthur Sh on 29.12.2022.
//

import SwiftUI

struct AddView: View {
    
    @EnvironmentObject var vm: ViewModelLogic
    @StateObject var model = ViewModel()

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack{
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
            Form{
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
                        Text("Short-info: ")
                        
                        TextField("Enter short information", text: $model.info)
                    }
                }
            }
            .navigationTitle("Add")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Button("Save") {
                    let new = Person(id: UUID(), name: model.name, image: model.inputImage ?? UIImage(systemName: "camera.circle")!)
                    
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
//    func loadImage() {
//        guard let inputImage = inputImage else { return }
//        image = Image(uiImage: inputImage)
//    }

}
struct addView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(ViewModelLogic())
    }
}
