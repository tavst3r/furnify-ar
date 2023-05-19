//
//  LoginPageModelDoi.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 16.05.2023.
//

import SwiftUI
import FirebaseAuth
class LoginPageModelDoi: ObservableObject {
    
    //Login
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var showPassword: Bool = false
    
    @Published var loggedIn: Bool = false

    //Register
    @Published var registerUser: Bool = false 
    @Published var re_Enter_Password : String = ""
    @Published var showReEnterPassword : Bool  = false
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    
    
    
    //Login call...
    func Login() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            DispatchQueue.main.async {
                self.showAlert = true
                self.alertTitle = "Oops!"
                self.alertMessage = "Invalid credentials. Please check your username and password."
            }
            return
        }
        
        do {
            try await AuthenticationManager.shared.signInUser(email: email, password: password)
            DispatchQueue.main.async {
                  self.loggedIn = true
                }
            
        } catch {
            DispatchQueue.main.async {
                self.showAlert = true
                self.alertTitle = "Oops!"
                self.alertMessage = "Invalid credentials. Please check your username and password."
            }

        }
    }
    
    //Register call...
    func Register() async throws {
        guard !email.isEmpty, !password.isEmpty, !re_Enter_Password.isEmpty else {
            print("Please fill in all the required fields.")
            
            DispatchQueue.main.async {
                self.showAlert = true
            }
            return
        }
        
        guard password == re_Enter_Password else {
            print("Passwords do not match.")
            
            DispatchQueue.main.async {
                self.showAlert = true
                self.alertTitle = "Oops!"
                self.alertMessage = "Passwords do not match."
            }
            return
        }

        do {
            let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
            let user = DBUser(auth: authDataResult)
            try await UserManager.shared.createNewUser(user: user)
            // User successfully created, you can handle the result here
            DispatchQueue.main.async {
                print("User signed up successfully.")
                self.showAlert = true
                self.alertTitle = "Account created!"
                self.alertMessage = "Your account has been successfully created."
            }
        } catch {
            // An error occurred during sign up, handle the error here
            print("Error signing up: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.showAlert = true
            }
        }
    }

    func ForgotPassowrd(){
        //Do action here...
    }
}


