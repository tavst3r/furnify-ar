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
    
@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    // MARK: - Properties
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                RootView()
                    .ignoresSafeArea(.keyboard)
            }
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

    FirebaseApp.configure()

    return true

  }

}

//
