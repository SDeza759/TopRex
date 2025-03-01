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
            NavigationView {
                Group {
                    if authViewModel.isLoggedIn {
                        HomeView()
                            .environmentObject(authViewModel)
                            .onAppear { // ✅ Debugging prints
                                print("DEBUG: Showing HomeView")
                            }
                    } else {
                        ContentView()
                            .environmentObject(authViewModel)
                            .onAppear { // ✅ Debugging prints
                                print("DEBUG: Showing ContentView")
                            }
                    }
                }
            }
        }
    }
}
