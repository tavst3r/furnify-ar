//
//  Product.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 30.04.2023.
//

import SwiftUI

//Product model...
struct Product: Identifiable,Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subtitle: String
    var description: String = " "
    var price: String
    var productImage: String = " "
    var quantity: Int = 1
}

// Product types...
enum ProductType: String, CaseIterable{
    case Tables = "Tables"
    case Chairs = "Chairs"
    case Beds = "Beds"
    
}
