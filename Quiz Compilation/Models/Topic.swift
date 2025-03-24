//
//  Topic.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 14.02.2025.
//

import Foundation

struct Topic: Identifiable, Hashable {
    var id = UUID().uuidString
    var name: String
    var description: String
    var image: String
    var questions: [Question]
}
