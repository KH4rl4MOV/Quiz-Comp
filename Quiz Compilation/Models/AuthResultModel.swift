//
//  AuthResultModel.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

import Foundation
import FirebaseAuth

struct AuthResultModel {
    var uid: String
    var email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email ?? ""
    }
}
