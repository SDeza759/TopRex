//
//  ContentView.swift
//  TopRex
//
//  Created by Sebastian Deza on 2/28/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Color
                Color.black
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    // Large "TRex" Text in the Center
                    Text("T-Rex")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.bottom, 200)

                    // Authentication Buttons
                    VStack(spacing: 12) {
                        // Apple Button (with black text)
                        SignInButton(title: "Continue with Apple", icon: "applelogo", backgroundColor: Color(UIColor.lightGray), textColor: .black)

                        // Google Button (with actual Google "G" logo)
                        SignInButton(title: "Continue with Google", imageName: "google_logo", backgroundColor: Color(UIColor.darkGray), textColor: .white)

                        // Sign Up Button
                        NavigationLink(destination: SignUpView().environmentObject(authViewModel)) {
                            Text("Sign up")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(UIColor.darkGray))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal, 40)
                        }

                        // Log In Button (with outline)
                        NavigationLink(destination: LoginView().environmentObject(authViewModel)) {
                            Text("Log in")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.clear)
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                                .padding(.horizontal, 40)
                        }
                    }
                    .padding(.bottom, 40)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// Reusable Sign-In Button
struct SignInButton: View {
    var title: String
    var icon: String? = nil
    var imageName: String? = nil
    var backgroundColor: Color
    var textColor: Color

    var body: some View {
        Button(action: {
            // Action for sign-in (implement later)
        }) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.trailing, 1)
                        .padding(.bottom, 1)
                }
                if let imageName = imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 1)
                }
                Text(title)
                    .font(.headline)
                    .foregroundColor(textColor)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .cornerRadius(10)
            .padding(.horizontal, 40)
        }
    }
}
