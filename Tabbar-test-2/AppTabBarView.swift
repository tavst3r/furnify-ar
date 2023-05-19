//
//  AppTabBarView.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 28.04.2023.
//

import SwiftUI

// Generics
// ViewBuilder
// PreferenceKey
// MatchedGeometryEffect

struct AppTabBarView: View {
    
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .home
    @Namespace var animation
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {

            HomesScreen22(animation: animation)
                .environmentObject(sharedData)
                    .tabBarItem(tab: .home, selection: $tabSelection)

                LikedPage()
                .environmentObject(sharedData)
                    .tabBarItem(tab: .favourites, selection: $tabSelection)

                ContentView()
                    .tabBarItem(tab: .ar, selection: $tabSelection)
            
                CartPage()
                .environmentObject(sharedData)
                    .tabBarItem(tab: .cart, selection: $tabSelection)

            ProfilePage()
                    .tabBarItem(tab: .profile, selection: $tabSelection)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .overlay(
            ZStack{
                //Detail page...
                if let product  = sharedData.detailProduct,sharedData.showDetailProduct{
                     
                    ProductDetailView(product: product, animation: animation)
                        .environmentObject(sharedData)
                    
                    //transitions...
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
    }
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
                    Image(systemName: "house")
                    Text("Home")
                }
            Color.blue
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            Color.orange
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
    
}

struct TestTabView: View {
    
    let text: String
    @State private var textFieldText: String = ""
    
    init(text: String) {
        self.text = text
        print("INIT" + text)
    }
    
    var body: some View {
        VStack {
            Text(text)
                .onAppear {
                    print("ONAPPEAR" + text)
            }
            TextField("Type something...", text: $textFieldText)
                .disableAutocorrection(true)
            
        }
    }
}
