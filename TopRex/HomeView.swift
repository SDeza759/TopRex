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
            Text("Welcome to T-Rex!")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Text("What can we recommend today?")
                .padding()
            
            Spacer()
        }
        .navigationTitle("Home")
        .navigationBarItems(trailing:
                    NavigationLink(destination: SettingsView().environmentObject(authViewModel)) { // ✅ Pass environment explicitly
                        Image(systemName: "gearshape.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
        )
    }

    /*func signOut() {
        do {
            try Auth.auth().signOut()
            // Handle logout (navigate back to login)
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }*/
}
