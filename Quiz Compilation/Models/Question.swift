//
//  Question.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 14.02.2025.
//

import Foundation

struct Question: Identifiable, Hashable {
    var id = UUID().uuidString
    var text: String
    var hint: String?
    var answer: String
    var variants: [String]
}
