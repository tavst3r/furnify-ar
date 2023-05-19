//
//  ModelPickerApp.swift
//  ModelPicker
//
//  Created by Fernando Fernandes on 24.07.20.
//

import SwiftUI
import Firebase

@main
struct ModelPickerApp: App {
    @State private var isLoading = true

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("signedId") private var signedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isLoading {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLoading = false
                        }
                    }
            } else {
                if signedIn {
                    AppTabBarView()
                } else {
                    LoginPage()
                }
            }
        }
    }
}

//NavigationStack {
//    RootView()
//        .ignoresSafeArea(.keyboard)
//}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
