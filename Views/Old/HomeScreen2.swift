//
//  HomeScreen2.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 30.04.2023.
//

import SwiftUI

struct HomeScreen2: View {
    @Namespace  var animation
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 15){
                
                //Search Bar
                HStack(spacing: 15){
                    Image("Search")
                        .foregroundColor(.gray)
                    
                    TextField("Search furniture" , text: .constant(""))
                        .disabled(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color.gray, lineWidth: 0.4)
                )
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                
                Text("Order online\nCollect in store")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment:.leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
            }
            .padding(.vertical)
            
            //Products tab...
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 18){
                    ForEach(ProductType.allCases, id:
                                \.self){ type in
                        
                        //                        Product Type View....
                        ProductTypeView(type: type)
                    }
                    }
                    
                    .padding(.horizontal, 25)
                }
                .padding(.top, 2)
                
            //Products page....
                ScrollView(.horizontal, showsIndicators: false){
                        
                    HStack(spacing: 10){
                        ForEach(homeData.products){product in
                            
              //Product card view...
                            ProductCardView(product: product)
                        }

                    .padding(.leading, 25)
                }
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.9686274529, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9450980425, green: 0.9725490212, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom))
    }
    
    @ViewBuilder
    func ProductCardView(product: Product)->some View{
        
        VStack(spacing: 10){
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
          //Moving images to the top...
                .offset(y: -80)
                .padding(.bottom, -80)
            
            Text(product.title)
                .font(.system(size: 18))
                .fontWeight(.semibold)
            
            Text(product.subtitle)
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundColor(.gray)
            
            Text(product.price)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
                .padding(.top, 5)
            
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        .padding(.top, 60)
    }
    
    @ViewBuilder
    func ProductTypeView(type: ProductType)-> some View{
        
        Button {
//            Updating current Type...
            withAnimation{
                homeData.productType = type
            }
        
        } label: {
            Text(type.rawValue)
                .fontWeight(.semibold)
//            Changing color based on product Type...
                .foregroundColor(homeData.productType == type ? Color.blue : Color.gray)
                .padding(.bottom, 10)
//            Adding indicator at bottom...
                .overlay(
                    
//                    Adding matched geometry effect...
                    ZStack{
                        if homeData.productType == type{
                            
                            Capsule()
                                .fill(Color.blue)
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        }
                        else {
                                Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                        
                    }
                        .padding(.horizontal, -5)
                        ,alignment: .bottom
                )
        }
    }
}

struct HomeScreen2_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen2()
    }
}

// Extending view to get screen bounds
extension View {
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
