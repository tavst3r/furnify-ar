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
                self.alertTitle = "Error"
                self.alertMessage = "Invalid credentials"
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
                self.alertTitle = "Error"
                self.alertMessage = "Invalid credentials"
            }

        }
    }
    
        
//        if self.email != ""{
//
//            if self.password == self.reEnterPassword{
//
//                Auth.auth().createUser(withEmail: self.email, password: self.password) { (res, err) in
//                    if err != nil{
//
//                        self.error = err!.localizedDescription
//                        self.alert.toggle()
//                        return
//                    }
//                    self.persistImageToStorage()
//                    self.error = "Account was created successfully"
//                    self.alert.toggle()
//                    print("success")
//                }
//            }
//            else{
//                self.error = "Password mismatch"
//                self.alert.toggle()
//            }
//        }
//        else{
//
//            self.error = "Please fill all the contents properly"
//            self.alert.toggle()
//        }
//    }
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
            }
            return
        }

        do {
            try await AuthenticationManager.shared.createUser(email: email, password: password)
            // User successfully created, you can handle the result here
            print("User signed up successfully.")
        } catch {
            // An error occurred during sign up, handle the error here
            print("Error signing up: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.showAlert = true
            }
        }
    }

        // Check credentials...
    
//    func checkIfUserIsLoggedIn(signedId: Bool) {
//        if Auth.auth().currentUser?.uid != nil {
//            signedId = true
//            }else{
//             signedId = false
//            }
//    }
    
    

    
    func ForgotPassowrd(){
        //Do action here...
    }
    
    func showAlert(title: String, message: String) {
        // Display the alert here using SwiftUI's alert mechanism
        // For example, you can have an @State property to control the alert presentation in the ContentView
        // and update that property here to trigger the alert
        
        // Example:
        // alertTitle = title
        // alertMessage = message
        // showAlert = true
    }
}


