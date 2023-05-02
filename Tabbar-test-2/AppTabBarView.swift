//
//  AppTabBarView.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 28.04.2023.
//

import SwiftUI

struct AppTabBarView: View {
    
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .home
//    ------------------- ------------
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            
            HomesScreen22()
                .tabBarItem(tab: .home, selection: $tabSelection)
            TestView()
                .tabBarItem(tab: .favourites, selection: $tabSelection)
            ContentView()
                .tabBarItem(tab: .ar, selection: $tabSelection)
            TestView2()
                .tabBarItem(tab: .cart, selection: $tabSelection)
            ProfilePage()
                .tabBarItem(tab: .profile, selection: $tabSelection)
            
        }
    }
    
//    ------------------- --------------------------
}

struct AppTabBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        AppTabBarView()
    }
}


extension AppTabBarView {
    
    private var defaultTabView: some View {
        TabView(selection: $selection) {
                  Color.red
                      .tabItem {
                          Image("home")
                          Text("Home")
                      }
                  
                  Color.blue
                      .tabItem {
                                          Image("favourites")
                                          Text("Favourites")
                                      }
                  Color.orange
                      .tabItem {
                                          Image("cart")
                                          Text("Cart")
                                      }
                  
                  Color.green
                                 .tabItem {
                                                     Image("profile")
                                                     Text("Profile")
                                                 }
            Color.pink
                                 .tabItem {
                                                     Image("ar.fill")
                                                     Text("AR")
                                                 }

              }
    }
    
}
