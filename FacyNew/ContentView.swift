//
//  ContentView.swift
//  FacyNew
//
//  Created by Arthur Sh on 29.12.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
   
    var body: some View {
        NavigationView {
            List{
                ForEach(vm.people) { person in
                        HStack {
                            Image(uiImage: person.image ?? UIImage(systemName: "plus")!)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 44)
                                .clipShape(Circle())
                            Text(person.name)
                        }
                    }
            }
            .toolbar{
                NavigationLink{
                    AddView(vm: vm)
                } label: {
                    Text("+")
                }
            }
            .sheet(isPresented: $vm.isAddViewShowing){
                AddView(vm: vm)
            }
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
