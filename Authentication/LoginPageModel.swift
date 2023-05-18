//
//  LoginPageModel.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 16.05.2023.
//

import SwiftUI

class LoginPageModel: ObservableObject {
    
    //Login
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var showPassword: Bool = false

    //Register
    @Published var re_Enter_Password : String = ""
    @Published var showReEnterPassword : Bool  = false
    
    //Login call...
        func logIn() async throws {
               guard !email.isEmpty, !password.isEmpty else {
                   print("No email or password found.")
                   return
               }
       
               try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
    func Register(){
        //Do action here...
    }
    
    func ForgotPassowrd(){
        //Do action here...
    }
}
