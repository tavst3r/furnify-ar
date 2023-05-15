//
//  HomesScreen22.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 01.05.2023.
//

import SwiftUI

struct HomesScreen22: View {
    var animation : Namespace.ID
    
    //Shared data...
    @EnvironmentObject var sharedData: SharedDataModel
    
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    var body: some View {
        
        VStack{
            Text("Order online\nCollect in store")
                .font(.system(size:28).bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.horizontal, 25)
            
            ScrollView(.vertical, showsIndicators: false){
                
                VStack(spacing: 15){
                    
                    //Search Bar...
                    
                    ZStack{
                        
                        if homeData.searchActivated{
                            SearchBar()
                        }
                        else{
                            SearchBar()
                                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                        }
                    }
                    .frame(width: getRect().width / 1.5)
                    .padding(.horizontal, 25)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            homeData.searchActivated = true
                        }
                    }
                    
                    //Products Tab...
                    
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack(spacing: 10){
                            
                            ForEach(ProductType.allCases, id:
                                        \.self){type in
                                
                                // Product Type View...
                                ProductTypeView(type: type)
                            }
                        }
                        .padding(.horizontal, 25)
                    }
                    .padding(.top, 28)
                    
                    //Products page...
                    ScrollView(.horizontal,showsIndicators: false){
                        
                        HStack(spacing: 25){
                            
                            ForEach(homeData.filteredProducts){ product in
                                
                                //Product card view...
                                ProductCardView(product: product)
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.bottom)
                        .padding(.top, 80)
                    }
                    .padding(.top, -28)
                    
                    //See more button...
                    //This button will show all products ON THE CURRENT TYPE, since here we can only see 4...
                    Button {
                        homeData.showMoreProductsOnType.toggle()
                    } label: {
                        
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("See more")
                        }
                        .font(.system(size: 15).bold())
                        .foregroundColor(Color.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
                    .padding(.top, 10)
                    
                }
                .padding(.vertical)
                
            }

            //Updating data whenever tab changes...
            .onChange(of: homeData.productType) {newvalue in
                homeData.filterProductByType()
            }
            
            .sheet(isPresented: $homeData.showMoreProductsOnType) {
            } content: {
                MoreProductsView()
            }
            //Displaying search view...
            .overlay(
                ZStack{
                    
                    if homeData.searchActivated{
                        SearchViewHome(animation: animation)
                            .environmentObject(homeData)
                    }
                }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.9686274529, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9450980425, green: 0.9725490212, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom))
    }
        
    @ViewBuilder
    func SearchBar()->some View{
        
        HStack(spacing: 15){
            Image ("Search")
                .foregroundColor(.gray)
            
            TextField("Search", text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
            
            Capsule()
                .strokeBorder(Color.gray, lineWidth: 0.4)
            
        )
    }
    
    @ViewBuilder
    func ProductCardView(product: Product)-> some View{
        
        VStack(spacing: 10){
            //Matched geo...
            ZStack{
                
                if sharedData.showDetailProduct{
                    
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                }
                else{
                    
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                }
            }
                .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
            //Moving the image to half top...
                .offset(y: -80)
                .padding(.bottom, -80)
            
            Text(product.title)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Text(product.price)
                .font(.system(size: 15))
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding(.top, 5)

        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        
        //Showing product detail when tapped...
        .onTapGesture {
            
            withAnimation(.easeInOut){
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
    
    @ViewBuilder
    func ProductTypeView(type: ProductType)-> some View{
        
        Button {
            //Updating current type...
            withAnimation{
                homeData.productType = type
            }
        } label: {
            
            Text(type.rawValue)
                .font(.system(size: 15))
                .fontWeight(.semibold)
            //Changing color based on current product type
                .foregroundColor(homeData.productType == type ? Color.blue : Color.gray)
                .padding(.bottom, 10)
            //Adding indicator / underline
                .overlay(
                
                    //Adding matched geometry effect...
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
        .padding(.bottom, 10)
    }
}

struct HomesScreen22_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBarView(showSignInView: .constant(false))
    }
}


