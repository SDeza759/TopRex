//
//  AuthViewModel.swift
//  TopRex
//
//  Created by Sebastian Deza on 2/28/25.
//


import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false

    init() {
        checkAuthState() // ✅ Ensure auth state is checked at launch
    }

    func checkAuthState() {
        DispatchQueue.main.async {
            self.isLoggedIn = Auth.auth().currentUser != nil
            print("DEBUG: Checked auth state - isLoggedIn: \(self.isLoggedIn)") // ✅ Debug message
        }
    }

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Sign-in failed - \(error.localizedDescription)") // ✅ Debugging print
            } else {
                DispatchQueue.main.async {
                    self.isLoggedIn = true
                    print("DEBUG: User signed in. isLoggedIn is now \(self.isLoggedIn)") // ✅ Debug message
                }
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.isLoggedIn = false
                print("DEBUG: User signed out. isLoggedIn is now \(self.isLoggedIn)") // ✅ Debugging print
            }
        } catch {
            print("DEBUG: Error signing out: \(error.localizedDescription)") // ✅ Debug message
        }
    }
}
