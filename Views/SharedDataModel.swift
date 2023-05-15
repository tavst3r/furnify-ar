//
//  SharedDataModel.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 03.05.2023.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    
    //Detail product data
    @Published var detailProduct: Product?
    @Published var showDetailProduct: Bool = false
    
    //Matched geometry effect from search
    @Published var fromSearchPage: Bool = false
    
    //Liked products
    @Published var likedProducts: [Product] = []
    
    //Cart products
    @Published var cartProducts: [Product] = []
    
    //Calculating total price...
    func getTotalPrice()->String {
        
        var total: Int = 0
        
        cartProducts.forEach { product in
            
            let price = product.price.replacingOccurrences(of: "RON", with: "") as NSString
            
            let quanity = product.quantity
            let priceTotal = quanity * price.integerValue
            
            total += priceTotal
        }
        
        return "\(total) RON"
    }
}
