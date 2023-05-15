//
//  SearchViewHome.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 01.05.2023.
//

import SwiftUI

struct SearchViewHome: View {
    @FocusState var isInputActive: Bool
    var animation: Namespace.ID
    
    //Shared data...
    @EnvironmentObject var sharedData: SharedDataModel
    
    @EnvironmentObject var homeData: HomeViewModel
    
    //Activating text field with Focus State...
    @FocusState var startTF: Bool
    var body: some View {
        ScrollView{
        VStack(spacing: 0){
            
            //Search bar...
            HStack(spacing: 20){
                
                //Close button...
                Button {
                    withAnimation{
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                    //Resetting...
                    sharedData.fromSearchPage = false
                    
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                
                //Search bar...
                HStack(spacing: 15){
                    Image ("Search")
                        .foregroundColor(.blue)
                    
                    TextField("Search", text: $homeData.searchText)
                        .focused($startTF)
                        .focused($isInputActive)
                    //                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Te am pwpat") {
                                    isInputActive = false
                                }
                            }
                        }
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    
                    Capsule()
                        .strokeBorder(Color.blue, lineWidth: 1.5)
                    
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
            }
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom, 10)
            
            //Showing progress if searching...
            //else showing no res found if empty...
            if let products = homeData.searchedProducts{
                
                if products.isEmpty{
                    
                    ScrollView{
                        //No results found...
                        VStack(spacing: 10){
                            
                            Image("NotFound2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300)
                                .padding(.top, 60)
                            
                            Text("Item not found")
                                .font(.system(size: 22).bold())
                            
                            Text("Try a more generic search term or try looking for alternative products.")
                                .font(.system(size: 22))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 30)
                            
                            Image("furnify-logo1")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120)
                                .padding(.horizontal)
                            //                            .padding(.top, 20)
                                .foregroundColor(.blue.opacity(0.5))
                        }
                        .padding()
                    }
                    .scrollDismissesKeyboard(.interactively)
                    
                }
                else{
                    //Filer results...
                    ScrollView(.vertical, showsIndicators: false){
                        
                        VStack(spacing: 0){
                            
                            //Found text...
                            Text("Found \(products.count) results")
                                .font(.system(size: 18).bold())
                                .padding(.vertical, 10)
                            //Staggered grid...
                            StaggeredGrid(columns: 2, spacing: 20, list: products){ product in
                                
                                //Card view...
                                ProductCardView(product: product)
                            }
                        }
                        .padding()
                    }
                    .scrollDismissesKeyboard(.interactively)
                }
            }
            else{
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
        }
    }
        .scrollDismissesKeyboard(.interactively)

            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9686274529, green: 0.9686274529, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.9450980425, green: 0.9725490212, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom))
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    startTF = true
                }
            }
        }
    
    @ViewBuilder
    func ProductCardView(product: Product)-> some View{
        
        VStack(spacing: 10){
            
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
                        .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
            }
            //Moving the image to half top...
                .offset(y: -50)
                .padding(.bottom, -50)
            
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
        .padding(.top, 50)
        .onTapGesture {
            withAnimation(.easeInOut){
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
                }
            }
        }
    }
    
    struct SearchViewHome_Previews: PreviewProvider {
        static var previews: some View {

            AppTabBarView(showSignInView: .constant(false))
        }
    }

