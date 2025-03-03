//
//  AuthViewModel.swift
//  TopRex
//
//  Created by Sebastian Deza on 2/28/25.
//


import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    
    init() {
        checkAuthState() // ✅ Ensure auth state is checked at launch
    }
    
    func checkAuthState() {
        DispatchQueue.main.async {
            self.isLoggedIn = Auth.auth().currentUser != nil
            if self.isLoggedIn {
                self.fetchUserData()
            }
            print("DEBUG: Checked auth state - isLoggedIn: \(self.isLoggedIn)") // ✅ Debug message
        }
    }
    
    func signIn(email: String, password: String) {
        print("DEBUG: signIn() called with email: \(email)")
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
    
    func fetchUserData() {
        guard let user = Auth.auth().currentUser else { return }
        self.userEmail = user.email ?? ""
        
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).getDocument { document, error in
            if let document = document, document.exists, let data = document.data() {
                self.userName = data["name"] as? String ?? "No Name"
            } else {
                self.userName = "No Name"
            }
        }
    }
    
    func updateUserName(newName: String, completion: @escaping () -> Void) {
        guard let user = Auth.auth().currentUser else { return }
        
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).setData(["name": newName], merge: true) { error in
            if let error = error {
                print("DEBUG: Failed to update name - \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.userName = newName
                    completion()
                }
            }
        }
    }
}
