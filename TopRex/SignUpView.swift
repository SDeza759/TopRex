//
//  SignUpView.swift
//  TopRex
//
//  Created by Sebastian Deza on 2/28/25.
//


import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .bold()
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: signUp) {
                Text("Create Account")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }

            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $isLoggedIn) {
            HomeView() // Navigate to home screen after sign-up
        }
    }

    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
                print("Sign-Up Error: \(error.localizedDescription)")
            } else {
                isLoggedIn = true
            }
        }
    }
}
