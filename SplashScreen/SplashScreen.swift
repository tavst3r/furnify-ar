//
//  SplashScreen.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 10.04.2023.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack{
            //        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Image("furnify-logo")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.red)
                .scaledToFit()
                .frame(width: 300, height: 200, alignment: .center)
            
            Text("elevate your living space")
                .font(.custom("Helvetica Neue Medium", size: 22))
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
