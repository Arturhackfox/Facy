//
//  VMContenView.swift
//  FacyNew
//
//  Created by Arthur Sh on 29.12.2022.
//

import Foundation
import SwiftUI
import LocalAuthentication

@MainActor class ViewModelLogic: ObservableObject {
    @Published var people = [Person]().sorted() {
        didSet {
            save()
        }
    }
    
    @Published var url = FileManager.directory.appendingPathComponent("PeopleFaces")
    
    @Published var isPHPickershowing = false
    @Published var isAddViewShowing = false
    
    enum AuthenticationStatus {
        case loading, loaded, failed
    }
    @Published var currentAuthenticationStatus = AuthenticationStatus.loading
    @Published var isAuthenticated = false

    
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
  
    
    func authentication() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success,  authenticationError in
                if success {
                    Task {
                        @MainActor in
                            self.currentAuthenticationStatus = .loaded
                            self.isAuthenticated = true
                            print("Authenticated")
                        
                    }
                } else {
                    Task{
                        @MainActor in
                            self.currentAuthenticationStatus = .failed
                            print("Failed to authenticate with biometrics, try again.")
                        
                    }
                }
            }
        }else {
            print("No biometrics found")
        }
    }

    
    
}
