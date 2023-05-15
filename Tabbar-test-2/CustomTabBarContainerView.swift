//
//  CustomTabBarContainerView.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 28.04.2023.
//

import SwiftUI

struct CustomTabBarContainerView<Content:View>: View {
    
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.bottom)
            
            CustomTabBarView(tabs: tabs, selection: $selection, localSelection: selection)
            
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

struct CustomTabBarContainerView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [
        .home, .favourites, .cart, .profile, .ar
    ]
        
        static var previews: some View {
            CustomTabBarContainerView(selection: .constant(tabs.first!)) {
                Color.red
            }
        }
    }
