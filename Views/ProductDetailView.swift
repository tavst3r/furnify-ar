//
//  ProductDetailView.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 03.05.2023.
//

import SwiftUI

struct ProductDetailView: View {
    

    //Individual corners...
    @State var topLeft: CGFloat = 25
    @State var topRight: CGFloat = 25
    
    var product: Product
    
    //For matched geo...
    var animation: Namespace.ID
    
    //Shared data model...
    @EnvironmentObject var sharedData: SharedDataModel
    
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        VStack{
            
            //Title bar + product image...
            VStack{
                
                //Title bar...
                HStack{

                    Button {
                        //Closing view...
                        withAnimation(.easeInOut){
                            sharedData.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }

                    Spacer()
                    
                    Button {
                        addToLiked()
                    } label: {
                        isLiked() ?
                        Image("favourites.fill")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(Color.blue)
                        :
                        
                        Image("favourites")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(Color.black.opacity(0.7))
                        
                    }

                    
                }
                .padding(.horizontal, 25)
                .padding(.top, 110)
            
                //Product image...
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            //Product details...
            ScrollView(.vertical, showsIndicators: false){
                
                //Product data...
                VStack(alignment: .leading, spacing: 15){
                        
                    Text(product.title)
                        .font(.system(size: 20).bold())
                    
                    Text(product.subtitle)
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                    
                    Text("Free delivery and assembly")
                        .font(.system(size:16).bold())
                        .padding(.top)
                    
                    Text("Available with any purchase over 1000 RON. Eexperience the convenience of hassle-free furniture shopping. Visit us today to find the perfect furniture for your home!")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    
                    Button {
                        
                    } label: {
                        
                        Label {
                           Image(systemName: "arrow.right")
                        } icon: {
                            Text("Read more")
                        }
                        .font(.system(size: 15).bold())
                        .foregroundColor(Color.blue)
                        
                    }

                    HStack{
                        
                        Text("Price")
                        
                        Spacer()
                        
                        Text("\(product.price)")
                            .font(.system(size: 20).bold())
                            .foregroundColor(Color.blue)
                    }
                    .padding(.vertical, 20)
                    
                    //Cart button...
                    Button {
                        addToCart()
                    } label: {
                        Text("\(isAddedToCart() ? "Added" : "Add") to cart")
                            .font(.system(size: 20) .bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                            
                                Color.blue
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y:5)
                            )
                    }

                }
                .padding([.horizontal,.bottom], 25)
                .padding(.top, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
            //Corner radius only for top side...
                    .cornerRadius(topLeft, corners: .topLeft)
                    .cornerRadius(topRight, corners: .topRight)
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .animation(.easeInOut, value: sharedData.likedProducts)
        .animation(.easeInOut, value: sharedData.cartProducts)

        .background(
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.9686274529, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9450980425, green: 0.9725490212, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea())
    }
    
    func isLiked()-> Bool{
        
        return sharedData.likedProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func isAddedToCart()-> Bool{
        
        return sharedData.cartProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func addToLiked(){
        
        if let index = sharedData.likedProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            //Remove from liked...
            sharedData.likedProducts.remove(at:index)
        }
        else{
            //add to liked
            sharedData.likedProducts.append(product)
        }
    }
    
    func addToCart(){
        
        if let index = sharedData.cartProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }){
            //Remove from liked...
            sharedData.cartProducts.remove(at:index)
        }
        else{
            //add to liked
            sharedData.cartProducts.append(product)
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //Sample product for preview...
//        ProductDetailView(product: HomeViewModel().products[0])
//            .environmentObject(SharedDataModel())
        
        AppTabBarView(showSignInView: .constant(false))
    }
}
