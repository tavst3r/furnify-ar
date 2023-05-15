//
//  CartPage.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 04.05.2023.
//

import SwiftUI

struct CartPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    
    //Delete option...
    @State var showDeleteOption: Bool = false

    var body: some View {
        
        NavigationView{
            VStack(spacing: 10){
                
                ScrollView(.vertical,showsIndicators: false){
                    
                    VStack{
                        HStack{
                         Text("Cart")
                                .font(.system(size: 28).bold())
                            
                            Spacer()
                            
                            Button {
                                withAnimation{
                                    showDeleteOption.toggle()
                                }
                            } label: {
                                Image ("Remove")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                            }
                            .opacity(sharedData.cartProducts.isEmpty ? 0  : 1)
                            
                        }
                        .padding(.leading, 10)
                        //Checking if liked products are empty...
                        if sharedData.cartProducts.isEmpty{
                            
                            Spacer(minLength: 121)
                            Group{
                                
                                Image("NoCart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300)
                                    .padding()
                                    .padding(.top, 35)
                                
                                Text("No items added")
                                    .font(.system(size: 25))
                                    .fontWeight(.semibold)
                                
                                Text("Hit the plus button to add items to your cart")
                                    .font(.system(size: 18))
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                    .padding(.top, 10)
                                    .multilineTextAlignment(.center)
                                
                                Image("furnify-logo1")
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 120)
                                    .padding(.horizontal)
                                    .padding(.top, 20)
                                    .foregroundColor(.blue.opacity(0.5))
                            }
                        
                        }
                        else{
                            //Displaying products...
                            VStack(spacing: 15){
                                
                                ForEach($sharedData.cartProducts){ $product in
                                    
                                    HStack(spacing: 0){
                                        
                                        if showDeleteOption{
                                            
                                            Button {
                                                deleteProduct(product: product)
                                            } label: {
                                                Image(systemName: "minus.circle.fill")
                                                    .font(.title2)
                                                    .foregroundColor(.red)
                                            }
                                            .padding(.trailing)
                                        }
                                        
                                        CardView(product: $product)
                                    }
                                }
                            }
                            .padding(.top, 25)
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
                
                //Showing total and Checkout button...
                if !sharedData.cartProducts.isEmpty{
                    
                    Group{
                        HStack{
                            
                            Text("Total")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(sharedData.getTotalPrice())
                                .font(.system(size:18).bold())
                                .foregroundColor(.blue)
                        }
                        
                        Button {
                            // momentan nu face nimic...
                        } label: {
                            Text("Checkout")
                                .font(.system(size: 18).bold())
                                .foregroundColor(.white)
                                .padding(.vertical, 18)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(15)
                                .shadow(color: .black.opacity(0.05), radius: 5, x: 5, y: 5)
                        }
                        .padding(.bottom, 80)
                        .padding(.vertical)
                    }
                    .padding(.horizontal, 25)
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.9686274529, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9450980425, green: 0.9725490212, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            )
        }
    }
    
    func deleteProduct(product: Product){
        
        if let index = sharedData.cartProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
            
         let _ = withAnimation{
                sharedData.cartProducts.remove(at: index)
            }
        }
    }
}

struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
    }
}

struct CardView: View {
     
    //Product as Binding for real-time updates...
    @Binding var product: Product
    
    var body: some View{
        
        HStack(spacing: 15){
        
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
        
            VStack(alignment: .leading, spacing: 8){
        
                Text(product.title)
                    .font(.system(size: 18).bold())
                    .lineLimit(1)
        
                Text(product.subtitle)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.blue)
        
                // Quantity buttons...
                HStack(spacing: 10){
                    Text("Quantity")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
        
                    Button {
                        product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                    } label: {
                     Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color.blue)
                            .cornerRadius(4)
                    }
        
                    Text("\(product.quantity)")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
        
                    Button {
                        product.quantity += 1
                    } label: {
                     Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color.blue)
                            .cornerRadius(4)
                    }
        
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
        
            Color.white
                .cornerRadius(10)
        )
    }
}


