//
//  ContentView.swift
//  FacyNew
//
//  Created by Arthur Sh on 29.12.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModelLogic()
    var locationFetcher = LocationFetcher()
    
    var body: some View {
        if vm.isAuthenticated {
            NavigationView {
                List{
                     ForEach(vm.people) { person in
                        ZStack {
                            NavigationLink {
                                DetailView(person: person)
                                    .environmentObject(vm)
                            }label: { } .opacity(0)
                            HStack {
                                Image(uiImage: person.image ?? UIImage(systemName: "camera.circle")!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 44, height: 44)
                                    .clipShape(Circle())
                                Text(person.name)
                                
                                Spacer()
                                
                                //MARK: custom info button
                                Image(systemName: "info.circle.fill")
                                    .resizable()
                                    .foregroundColor(.blue)
                                    .offset(x: 0, y: 0)
                                    .frame(width: 22, height: 22)
                            }
                        }
                        
                    }
                    .onDelete(perform: deleteRow)
                }
                .task {
                    locationFetcher.start()
                }
                .navigationTitle("Facy📁")
                .toolbar{
                    Button{
                        vm.isPHPickershowing = true
                    } label: {
                        Image(systemName: "plus")
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
        } else {
            Button{
                vm.authentication()
            } label: {
                Text("Authenticate")
                    .padding()
                    .frame(width: 150, height: 100)
                    .foregroundColor(.white)
                    .background(.green)
                    .cornerRadius(12)
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
