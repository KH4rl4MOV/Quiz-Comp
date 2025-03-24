//
//  ProfileViewModel.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

extension ProfileView {
    final class ViewModel: ObservableObject {
        @Published var password = ""
        @Published var errorMessage = ""
        @Published var isEditing = false
        @Published var showImagePicker = false
        @Published var showPasswordAlert = false
        @Published var isSaving = false
        @Published var isAnonymous = false
        
        private let db = Firestore.firestore()
        
        func fetchUserProfile() {
            guard let user = Auth.auth().currentUser else {
                errorMessage = "User not logged in"
                return
            }
            isAnonymous = user.isAnonymous
        }
        
        private func reauthenticateUser(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
            let email = "user@example.com"
            let password = "password"
            let credential = EmailAuthProvider.credential(withEmail: email, password: password)
            
            user.reauthenticate(with: credential) { result, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
        
        func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void) {
            guard let user = Auth.auth().currentUser else {
                completion(.failure(NSError(domain: "No user logged in", code: -1, userInfo: nil)))
                return
            }
            
            let uid = user.uid
            
            user.delete { [weak self] error in
                if let error = error {
                    if let errCode = AuthErrorCode(rawValue: error._code), errCode == .requiresRecentLogin {
                        self?.reauthenticateUser(user: user) { result in
                            switch result {
                            case .success:
                                user.delete { error in
                                    if let error = error {
                                        completion(.failure(error))
                                    } else {
                                        self?.deleteUserData(uid: uid, completion: completion)
                                    }
                                }
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
                    } else {
                        completion(.failure(error))
                    }
                } else {
                    self?.deleteUserData(uid: uid, completion: completion)
                }
            }
        }
        
        private func deleteUserData(uid: String, completion: @escaping (Result<Void, Error>) -> Void) {
            let docRef = Firestore.firestore().collection("users").document(uid)
            
            docRef.delete { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
        
        func reauthenticateAndDeleteAccount(password: String, completion: @escaping (Result<Void, Error>) -> Void) async throws {
            guard let user = Auth.auth().currentUser, let email = user.email else {
                completion(.failure(NSError(domain: "No user logged in or email not found", code: -1, userInfo: nil)))
                return
            }
            
            let credential = EmailAuthProvider.credential(withEmail: email, password: password)
            
            user.reauthenticate(with: credential) { [weak self] result, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                self?.deleteAccount(completion: completion)
            }
        }
        
        func logOut() throws {
            try Auth.auth().signOut()
        }
    }
}
