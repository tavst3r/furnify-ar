//
//  LoginViewNou.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 16.05.2023.
//

import SwiftUI

//@MainActor
//final class LogInEmailViewModel: ObservableObject{
//    
//    @Published var email = ""
//    @Published var password = ""
//    @Published var showPassword : Bool = false
//    
//    func signUp() async throws {
//        guard !email.isEmpty, !password.isEmpty else {
//            print("No email or password found.")
//            return
//        }
//        
//        try await AuthenticationManager.shared.signInUser(email: email, password: password)
//    }
//    
//    func logIn() async throws {
//        guard !email.isEmpty, !password.isEmpty else {
//            print("No email or password found.")
//            return
//        }
//        
//        try await AuthenticationManager.shared.createUser(email: email, password: password)
//    }
//}

struct LoginViewNou: View {
        
        @State var showPassword: Bool = false
        @ObservedObject private var viewModel = LogInEmailViewModel()
    
    var body: some View {
            VStack{
                VStack{
                    Text("Hello!")
                        .font(.system(size: 55).bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: getRect().height / 3.5)
                        .padding()
                        
                    ScrollView(.vertical, showsIndicators: false){
                        
                        VStack{
                            Text("Login")
                                .font(.system(size: 22).bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
//                            TextField("Email", text: $viewModel.email)
//                                .padding()
//                                .background(Color.gray.opacity(0.2))
//                                .cornerRadius(10)
                            
                            CustomTextField(icon: "envelope", title: "Email", hint: "Enter your email", value: $viewModel.email, showPassword: .constant(false))
                                .padding(.top, 25)
                            
//                            SecureField("Password", text: $viewModel.password)
//                                .padding()
//                                .background(Color.gray.opacity(0.2))
//                                .cornerRadius(10)
                            
                            CustomTextField(icon: "lock", title: "Password", hint: "Enter your password", value: $viewModel.password, showPassword: $showPassword)
                                .onTapGesture {
                                    showPassword.toggle()
                                }
                                .padding(.top, 10)
                            
                            Button {
                                Task{
                                    do{
                                        try await viewModel.signUp()
//                                        showSignInView = false
                                        return
                                    } catch {
                                        print(error)
                                    }
                                    
                                    do{
                                        try await viewModel.logIn()
//                                        showSignInView = false
                                        return
                                    } catch {
                                        print(error)
                                    }
                                    
                                    }
                                } label: {
                                    Text("Log in")
                                        .font(.system(size:18))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 55, alignment: .center)
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }
                                Spacer()
                            }
                        .padding(30)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight:  .infinity)
                    .background(
                        Color.white
                            .clipShape(RoundedCorner(radius: 25, corners: [.topLeft,.topRight]))
                            .ignoresSafeArea()
                    )
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("bglogin")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            )
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
            
            TextField(hint, text: value)
                .padding(.top, 2)
            
            Divider()
                .background(Color.blue.opacity(0.4))
            
        }
    }
    
}

struct LoginViewNou_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewNou()
    }
}
