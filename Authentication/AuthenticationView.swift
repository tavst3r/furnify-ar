//
//  AuthenticationView.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 11.05.2023.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Binding var showSignInView :Bool
    
    var body: some View {
        VStack{
            
            NavigationLink {
                LoginViewNou(showSignInView: $showSignInView)
            } label: {
                Text("Sign up with email")
                    .font(.system(size:18))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55, alignment: .center)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
            .navigationTitle("Log in")
        
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AuthenticationView(showSignInView: .constant(false))
        }
    }
}
