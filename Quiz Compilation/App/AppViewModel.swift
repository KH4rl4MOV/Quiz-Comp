//
//  AppViewModel.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

import Foundation
import FirebaseAuth
import SwiftUI

class AppViewModel: ObservableObject {
    @Published var status: ScreenTrace = .login
    @AppStorage("isLoggedIn") var isLogin = false

    func changeIsLogin(_ value: Bool) {
        isLogin = value
    }
    
    func signInAnonymously() {
        Auth.auth().signInAnonymously { [weak self] authResult, error in
            if let error = error {
                print("Anonymous login error: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self?.status = .main
                    self?.changeIsLogin(true)
                }
            }
        }
    }
}

