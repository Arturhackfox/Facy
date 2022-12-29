//
//  ContentView.swift
//  FacyNew
//
//  Created by Arthur Sh on 29.12.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModelLogic()
    
    var body: some View {
        NavigationView {
            List{
                ForEach(vm.people) { person in
                    NavigationLink {
                        DetailView(person: person)
                    }label: {
                        HStack {
                            Image(uiImage: person.image ?? UIImage(systemName: "camera.circle")!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 44, height: 44)
                                .clipShape(Circle())
                            Text(person.name)
                        }
                    }
                }
                .onDelete(perform: deleteRow)
            }
            .toolbar{
                Button{
                vm.isPHPickershowing = true
                } label: {
                    Text("+")
                }
                .sheet(isPresented: $vm.isPHPickershowing) {
                    NavigationView{
                        AddView()
                            .environmentObject(vm)
                            .toolbar {
                               
                            }
                    }
                }
            }
        }
        
    }
    func deleteRow(at offset: IndexSet) {
        for offset in offset {
            vm.people.remove(at: offset)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
