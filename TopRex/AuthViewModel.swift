//
//  AuthViewModel.swift
//  TopRex
//
//  Created by Sebastian Deza on 2/28/25.
//


import FirebaseAuth
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = Auth.auth().currentUser != nil
    init() {
        self.isLoggedIn = Auth.auth().currentUser != nil
        print("DEBUG: Initial Auth State - isLoggedIn: \(isLoggedIn)")
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.isLoggedIn = false
                print("DEBUG: User signed out. isLoggedIn is now \(self.isLoggedIn)")
            }
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
