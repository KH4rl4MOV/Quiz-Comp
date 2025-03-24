//
//  AuthManager.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    func getAuthUser() throws -> AuthResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthResultModel(user: user)
    }
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthResultModel {
        let authRes = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthResultModel(user: authRes.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthResultModel {
        let authRes = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthResultModel(user: authRes.user)
    }
    
    @discardableResult
    func signInAnonymously() async throws -> AuthResultModel {
        let authRes = try await Auth.auth().signInAnonymously()
        return AuthResultModel(user: authRes.user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}

extension Auth {
    func createUserAsync(withEmail email: String, password: String) async throws -> AuthDataResult {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<AuthDataResult, Error>) in
            self.createUser(withEmail: email.lowercased(), password: password) { authResult, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let authResult = authResult {
                    continuation.resume(returning: authResult)
                } else {
                    continuation.resume(throwing: NSError(domain: "UnknownError", code: -1, userInfo: nil))
                }
            }
        }
    }
}
