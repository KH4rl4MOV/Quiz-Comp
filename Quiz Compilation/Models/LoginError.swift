//
//  LoginError.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

import Foundation


enum LoginError: Error {
    case incorrectEmailOrPass
    case failedRegistation
    case noInternet
}

extension LoginError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .incorrectEmailOrPass:
            return "Incorrect username or password"
        case .noInternet:
            return "No internet"
        case .failedRegistation:
            return "Something went wrong"
        }
    }
}
