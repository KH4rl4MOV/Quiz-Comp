//
//  LoginViewModel.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

import Foundation

extension LoginView {
    final class ViewModel: ObservableObject {
        @Published var email: String = ""
        @Published var password = ""
        @Published var errorText = ""
        @Published var goToRegistration = false
        
        func signIn() async throws {
            guard !email.isEmpty, !password.isEmpty else {
                throw LoginError.incorrectEmailOrPass
            }
            try await AuthManager.shared.signInUser(email: email.lowercased(), password: password)
        }
        
        func signInAnonymously() async throws {
            try await AuthManager.shared.signInAnonymously()
        }
    }
}
