//
//  LoginView.swift
//  TopRex
//
//  Created by Sebastian Deza on 2/28/25.
//


import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoggedIn = false

    var body: some View {
        VStack {
            Text("Log In")
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

            Button(action: logIn) {
                Text("Log In")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }

            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $isLoggedIn) {
            HomeView() // Navigate to home screen after login
        }
    }

    func logIn() {
        print("DEBUG: Login button tapped")
        authViewModel.signIn(email: email, password: password)
    }
}
