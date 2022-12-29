//
//  VMContenView.swift
//  FacyNew
//
//  Created by Arthur Sh on 29.12.2022.
//

import Foundation
import SwiftUI

@MainActor class ViewModelLogic: ObservableObject {
    @Published var people = [Person]().sorted() {
        didSet {
            save()
        }
    }
    
    @Published var url = FileManager.directory.appendingPathComponent("PeopleFaces")
    
    @Published var isPHPickershowing = false
    @Published var isAddViewShowing = false

    
    // MARK: decodes and reads data when instance of ViewModel created EACH START
    init() {
        do{
            let data = try Data(contentsOf: url)
            people = try JSONDecoder().decode([Person].self, from: data)
        } catch {
            people = []
        }
    }
    
    // MARK: Adds new :Person type to array of people
    func addPerson(person: Person) {
        people.append(person)
        save()
    }
    
        // MARK: writes and saves encoded data to user's document directory
    func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: url)
            print("write success")
        } catch {
            print("failed to write data")
        }
    }
  

    
    
}
