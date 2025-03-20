//
//  RegistrationViewModel.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

extension RegistrationView {
    final class ViewModel: ObservableObject {
        @Published var email = ""
        @Published var password = ""
        @Published var confirmPass = ""
        @Published var errorText = ""
        var aboutText = ""

        @MainActor
        func register() async throws {
            guard email != "" && password != "" && confirmPass != "" else {
                self.errorText = "Fill in all the data"
                return
            }
            
            guard isValidEmail(email) else {
                self.errorText = "Enter the correct email"
                return
            }
            
            guard password == confirmPass else {
                self.errorText = "Passwords don't match"
                return
            }

            do {
                let authResult = try await Auth.auth().createUserAsync(withEmail: email, password: password)
                let uid = authResult.user.uid
                
                self.errorText = ""
                
                let userData: [String: Any] = [
                    "email": self.email,
                    "about": self.aboutText
                ]
                
                try await Firestore.firestore().collection("users").document(uid).setDataAsync(userData)
            } catch {
                self.errorText = error.localizedDescription
                print(error.localizedDescription)
            }
        }
        
        private func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
    }
}

extension DocumentReference {
    func setDataAsync(_ documentData: [String: Any]) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            self.setData(documentData) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: ())
                }
            }
        }
    }
}

