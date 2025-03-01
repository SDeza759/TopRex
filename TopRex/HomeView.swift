//
//  HomeView.swift
//  TopRex
//
//  Created by Sebastian Deza on 2/28/25.
//


import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        VStack {
            Text("Welcome to TopRex!")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Text("Start exploring the top recommendations.")
                .padding()
            
            Button(action: {
                authViewModel.signOut()
            }) {
                Text("Log Out")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            // Handle logout (navigate back to login)
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
