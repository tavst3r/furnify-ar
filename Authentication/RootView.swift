//
//  RootView.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 11.05.2023.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                AppTabBarView(showSignInView: $showSignInView)
            }
        }
        .onAppear{
            let authUser = try?AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
