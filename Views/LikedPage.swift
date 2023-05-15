//
//  LikedPage.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 03.05.2023.
//

import SwiftUI

struct LikedPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    
    //Delete option...
    @State var showDeleteOption: Bool = false

    var body: some View {
        
        NavigationView{
            ScrollView(.vertical,showsIndicators: false){
                
                VStack{
                    HStack{
                     Text("Favourites")
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
                        .opacity(sharedData.likedProducts.isEmpty ? 0  : 1)
                        
                    }
                    .padding(.leading, 10)

                    //Checking if liked products are empty...
                    if sharedData.likedProducts.isEmpty{
                        
                        Spacer(minLength: 121)
                        Group{
                            
                            Image("NoLikes")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300)
                                .padding()
                                .padding(.top, 35)
                            
                            Text("No favourites yet :(")
                                .font(.system(size: 25))
                                .fontWeight(.semibold)
                            
                            Text("Hit the like button on each product page to save your favourites")
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
                            ForEach(sharedData.likedProducts){ product in
                                
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
                                    
                                    CardView(product: product)
                                }
                            }
                        }
                        .padding(.top, 25)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.9686274529, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9450980425, green: 0.9725490212, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            )
        }
    }
    
    @ViewBuilder
    func CardView(product: Product)-> some View{
        
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
                
                Text("Type: \(product.type.rawValue)")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
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
    func deleteProduct(product: Product){
        
        if let index = sharedData.likedProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
            
         let _ = withAnimation{
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())
    }
}
