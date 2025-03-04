//
//  TopRexApp.swift
//  TopRex
//
//  Created by Sebastian Deza on 2/28/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct TopRexApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authViewModel.isLoggedIn {
                    NavigationView { // ✅ Ensure navigation is inside Group
                        HomeView()
                            .environmentObject(authViewModel)
                            .onAppear {
                                print("DEBUG: Showing HomeView")
                            }
                    }
                } else {
                    NavigationView { // ✅ Ensure navigation works in both states
                        ContentView()
                            .environmentObject(authViewModel)
                            .onAppear {
                                print("DEBUG: Showing ContentView")
                            }
                    }
                }
            }
        }
    }
}
