//
//  SignInEmailView.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 11.05.2023.
//

import SwiftUI

@MainActor

struct LoginInEmailView: View {

    @StateObject private var viewModel = LogInEmailViewModel()
//    @Binding var showSignInView: Bool

    var body: some View {
        VStack{
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            Button {
                Task{
                    do{
                        try await viewModel.signUp()
//                        showSignInView = false
                        return
                    } catch {
                        print(error)
                    }

                    do{
                        try await viewModel.logIn()
//                        showSignInView = false
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
            .padding()

            .navigationTitle("Sign up with email")
        }
    }

    struct LogInEmailView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationStack{
                LoginInEmailView()
            }
        }
    }
