//
//  addView.swift
//  FacyNew
//
//  Created by Arthur Sh on 29.12.2022.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var vm: ViewModel
    
    @State var name = ""
    @State var age = ""
    @State var info = ""
    @State  var imageDidLoad = false
    @State var inputImage: UIImage?
    @State var image: Image?
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.gray)
                    .opacity(imageDidLoad ? 0 : 100)
                    .frame(width: 370, height: 370)
                Text("TAP TO SELECT IMAGE")
                    .font(.title)
                    .opacity(imageDidLoad ? 0 : 100)
                    .foregroundColor(.white)
                image?
                    .resizable()
                    .scaledToFit()
                
            }
            .onTapGesture {
                imageDidLoad = true
                vm.isPhotoPickerShowing = true
            }
            Form{
                Section{
                    HStack {
                        Text("Name: ")
                        
                        TextField("Enter person's name", text: $name)
                            .textInputAutocapitalization(.never)
                    }
                }
                
                Section{
                    HStack {
                        Text("Age: ")
                        
                        TextField("Enter person's age", text: $age)
                    }
                }
                
                Section{
                    HStack {
                        Text("Short-info: ")
                        
                        TextField("Enter short information", text: $info)
                    }
                }
            }
            .navigationTitle("Add")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Button("Save") {
                    let new = Person(id: UUID(), name: name, image: inputImage ?? UIImage(systemName: "plus")!)
                    vm.addPerson(person: new)
                    dismiss()
                }
            }
            .sheet(isPresented: $vm.isPhotoPickerShowing) {
                imagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in loadImage()}
        }
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }

}
//struct addView_Previews: PreviewProvider {
//    static var previews: some View {
//        addView()
//    }
//}
