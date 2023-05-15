//
//  HomeViewModel.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 30.04.2023.
//

import SwiftUI

//Using combine to monitor search field, if user leaves for .5 secs then starts searching...
//to avoid memory issues...
import Combine


class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .Beds
    
//    Sample products...
    @Published var products: [Product] = [
        Product(type: .Beds, title: "Soho Bed", subtitle: "Series 1", price: "1500 RON", productImage: "pat1"),
        Product(type: .Beds, title: "Manhattan Bed", subtitle: "Series 2", price: "1200 RON", productImage: "pat2"),
        Product(type: .Beds, title: "Avalon Bed", subtitle: "Series 2", price: "1800 RON", productImage: "pat3"),
        Product(type: .Beds, title: "Riviera Bed", subtitle: "Series 2", price: "2000 RON", productImage: "pat4"),
        Product(type: .Beds, title: "Sanctum Bed", subtitle: "Series 2", price: "2000 RON", productImage: "pat5"),
        
        //
        Product(type: .Chairs, title: "Earnes Chair", subtitle: "Series 1", price: "200 RON", productImage: "scaun1"),
        Product(type: .Chairs, title: "Wingback Chair", subtitle: "Series 1", price: "350 RON", productImage: "scaun3")
        
    ]
    
    //Filtered products...
    @Published var filteredProducts: [Product] = []
    
    //More products on the type...
    @Published var showMoreProductsOnType: Bool = false
    
    //Search data...
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?
    
    var searchCancellable: AnyCancellable?
    
    init(){
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != ""{
                    self.filterProductBySearch()
                }
                else{
                    self.searchedProducts = nil
                }
            })
    }
    
    func filterProductByType(){
        
        //Filtering products by product type...
        DispatchQueue.global(qos: .userInteractive) .async {
            
            let results = self.products
            //It requires more memory so we use lazy to perform better
                .lazy
                .filter {product in
                    
                    return product.type == self.productType
                }
            
            //Limiting result...
                .prefix(4)
            
            DispatchQueue.main.async {
                
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch(){
        
        //Filtering products by product type...
        DispatchQueue.global(qos: .userInteractive) .async {
            
            let results = self.products
            //It requires more memory so we use lazy to perform better
                .lazy
                .filter {product in
                    
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                
                self.searchedProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}
