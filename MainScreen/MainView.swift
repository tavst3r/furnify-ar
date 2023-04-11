//
//  MainView.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 29.03.2023.
//

import SwiftUI

struct MainView: View {
    @State var selectedIndex = 0
    @State var presented = false
    var body: some View {
        TabView {
                   ContentView()
                       .tabItem {
                           Label("Profile", image: "profile")
                       }

            TestView ()
                       .tabItem {
                           Label("Favourites", image: "heart.outline")
                       }
            SplashScreen()
                .tabItem {
                    Label("Coș", image: "cart")
                }
               }
    }

    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            MainView()
        }
    }
}
//