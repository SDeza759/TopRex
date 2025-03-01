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

    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.isLoggedIn = false
            }
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
