//
//  LogInEmailViewModel.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 16.05.2023.
//

import Foundation
final class LogInEmailViewModel: ObservableObject{

    @Published var email = ""
    @Published var password = ""

    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }

        let authDataResult = try await AuthenticationManager.shared.signInUser(email: email, password: password)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
//        try await UserManager.shared.createNewUser(auth: authDataResult)
    }

    func logIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }

        try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
}

