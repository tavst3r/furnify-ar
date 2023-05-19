//
//  LoginPage.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 16.05.2023.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginPageModelDoi = LoginPageModelDoi()

    
    var body: some View {
        VStack{
                
//                Text("Hello!")
//                    .font(.system(size: 55).bold())
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                        .frame(height: getRect().height / 3.5)
//                        .padding(.leading,25)
                Spacer(minLength: 300)
            ScrollView(.vertical, showsIndicators: false){
             
                //Login form
                VStack(spacing: 15){
                    Text(loginData.registerUser ? "Register" :"Login")
                        .font(.system(size: 22).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //Custom text field
                    CustomTextField(icon: "envelope", title: "Email", hint: "Enter your email", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top, 30)
                    
                    CustomTextField(icon: "lock", title: "Password", hint: "Enter your password", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top, 10)

                    //Register reenter password
                    if loginData.registerUser{
                        CustomTextField(icon: "lock", title: "Re-enter Password", hint: "Enter the password again", value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterPassword)
                            .padding(.top, 10)
                    }
                    
                    //Forgot password button...
                    Button {
                        loginData.ForgotPassowrd()
                    } label: {
                        
                        Text("Forgot password?")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.blue)
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //Login button...
//                    Button {
//                        if loginData.registerUser{
//                            Task{
//                                do {
//                                try await loginData.Register()
//                                } catch {
//                                    print(error)
//                                }
//                        }
//                        }
//                        else {
//                            Task{
//                                do{
//                                    try await loginData.Login()
////                                    loginData.checkIfUserIsLoggedIn(signedId: showSignInView)
//                                    showSignInView = false
//                                    return
//                                } catch {
//                                    print(error)
//                                }
//                            }
////                            loginData.Login()
//                        }
                    
                    Button {
                        if loginData.registerUser {
                            Task {
                                do {
                                    try await loginData.Register()
                                } catch {
                                    print(error)
                                }
                            }
                        } else {
                            Task {
                                do {
                                    try await loginData.Login()
//                                    if loginData.loggedIn {
//                                        DispatchQueue.main.async {
//                                            showSignInView = false
//                                        }
//                                    } 1.Scos
                                } catch {
                                    print(error)
                                }
                            }
                        }
                    
                    } label: {
                        
                        Text("Login")
                            .font(.system(size: 17).bold())
                            .padding(.vertical, 20)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                    
                    //Register user...
                    
                    Button {
                        withAnimation{
                            loginData.registerUser.toggle()
                        }
                    } label: {
                        
                        Text(loginData.registerUser ? "Back to login" : "Create account")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.blue)
                    }
                    .padding(.top, 8)
                    
                }
                .padding(30)
                
            }
            .scrollDismissesKeyboard(.interactively)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(RoundedCorner(radius: 25, corners: [.topLeft,.topRight]))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("bglogin3")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 0, maxWidth: .infinity)
            .edgesIgnoringSafeArea(.all)
        )
        .ignoresSafeArea(.keyboard)
        .alert(isPresented: $loginData.showAlert) {
            Alert(title: Text(loginData.alertTitle), message: Text(loginData.alertMessage), dismissButton: .cancel())
        }
        
        //Clearing data when changed...
        .onChange(of: loginData.registerUser) { newValue in
            
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
        }
    }
    
    @ViewBuilder
    func CustomTextField (icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>) -> some View {
        VStack(alignment: .leading, spacing: 12){
            
            Label {
                Text(title)
                    .font(.system(size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue{
                SecureField(hint, text: value)
                    .padding(.top, 2)
            } else {
                TextField(hint, text: value)
                    .padding(.top, 2)
            }
            
            Divider()
                .background(Color.blue.opacity(0.4))
        }
        
        //Show button for password...
        .overlay(

            Group{
                
                if title.contains("Password"){
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.system(size: 13).bold())
                            .foregroundColor(Color.blue)
                    })
                    .offset(y: 8)
                }
            }
            
            ,alignment: .trailing
        )
    }
    
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
