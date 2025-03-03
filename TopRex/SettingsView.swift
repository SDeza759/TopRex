//
//  SettingsView.swift
//  TopRex
//
//  Created by Sebastian Deza on 3/3/25.
//


import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var newName: String = ""
    @State private var showAlert = false

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Account")) {
                    HStack {
                        Text("Name:")
                        Spacer()
                        TextField("Enter new name", text: $newName)
                            .multilineTextAlignment(.trailing)
                    }

                    HStack {
                        Text("Email:")
                        Spacer()
                        Text(authViewModel.userEmail)
                            .foregroundColor(.gray)
                    }

                    Button(action: {
                        updateUserName()
                    }) {
                        Text("Save Changes")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

                Section {
                    Button(action: {
                        authViewModel.signOut()
                    }) {
                        Text("Log Out")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .navigationTitle("Settings")
        .onAppear {
            self.newName = authViewModel.userName
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success"), message: Text("Your name has been updated."), dismissButton: .default(Text("OK")))
        }
    }

    func updateUserName() {
        authViewModel.updateUserName(newName: newName) {
            showAlert = true
        }
    }
}
