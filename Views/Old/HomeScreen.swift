//
//  HomeScreen.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 29.04.2023.
//

import SwiftUI

struct HomeScreen: View {
    @State private var selectedIndex: Int = 0
    private let categories = ["All", "Bathroom", "Bedroom", "Kitchen", "Living Room"]
    
    var body: some View {
        ZStack {
            Color(.gray)
                .edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .leading) {
                TaglineView()
                    .padding()
                
                SearchView()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack{
                        ForEach(0 ..< categories.count) { i in
                            CategoryView(isActive: i == selectedIndex, text: categories[i])
                                .onTapGesture {
                                    selectedIndex = i
                                }
                        }
                    }
                    .padding()
                }
                
                Text ("Popular")
                    .font(.custom("Sygma Bold", size: 24))
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0 ..< 4) { index in
                            ProductCardView(image: Image("scaun\(index + 1)"))
                        }
                        .padding(.trailing)
                    }
                    .padding(.leading)
                }
                
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

struct TaglineView: View {
    var body: some View {
        Text("Find the \nbest ")
            .font(.custom("Sygma", size: 32))
            .foregroundColor(Color(.blue))
        + Text ("Furniture")
            .font(.custom("Sygma Bold", size: 32))
            .foregroundColor(.blue)
    }
}

struct SearchView: View {
    @FocusState var isInputActive: Bool
    @State private var search: String = ""
    var body: some View {
        HStack{
            HStack {
                Image("Search")
                    .padding(.trailing, 8)
                TextField("Search furniture", text: $search)
                    .frame(maxWidth: 280)
                    .focused($isInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                                                Spacer()

                                                Button("Te am pwpat") {
                                                    isInputActive = false
                            }
                        }
                    }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct CategoryView: View {
    let isActive: Bool
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text(text)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(isActive ? Color(.blue) : Color.black.opacity(0.5))
            
            if (isActive) { Color(.blue)
                    .frame(width: 15, height: 2)
                    .clipShape(Capsule())
            }
        }
        .padding(.trailing)
    }
}

struct ProductCardView: View {
    let image: Image
    
    var body: some View {
        VStack{
            image
                .resizable()
            
                .frame(width: 210, height: 200)
                .cornerRadius(20)
            
            HStack {
                Text("Luxury chair")
                    .font(.title3)
                    .fontWeight(.medium)
                
                Text ("199 RON")
                    .font(.title3)
                    .fontWeight(.bold)
            }
        }
        .frame(width: 210)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}
