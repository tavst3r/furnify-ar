//
//  TabBarItem.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 28.04.2023.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    case home, favourites, cart, profile, ar
    
    var iconName: String {
        switch self {
        case.home: return "home"
        case.favourites: return "favourites"
        case.cart: return "cart"
        case.profile: return "profile"
        case.ar: return "ar.fill"
        }
    }
    
    var title: String {
        switch self {
        case.home: return "Home"
        case.favourites: return "Favourites"
        case.cart: return "Cart"
        case.profile: return "Profile"
        case.ar: return "Explore"
        }
    }
    
    var color: Color {
        switch self {
        case.home: return Color.blue
        case.favourites: return Color.blue
        case.cart: return Color.blue
        case.profile: return Color.blue
        case.ar: return Color.blue
        }
    }
    
    var fillIcon: String {
        switch self {
        case .home: return "home.fill"
        case .favourites: return "favourites.fill"
        case .cart: return "cart.fill"
        case .profile: return "profile.fill"
        case .ar: return "ar.fill"
        }
    }
}

