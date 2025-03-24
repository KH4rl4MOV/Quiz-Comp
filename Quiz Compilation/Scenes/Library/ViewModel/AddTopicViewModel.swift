//
//  AddTopicViewModel.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension AddTopicView {
    class ViewModel: ObservableObject {
        @Published var name: String = ""
        @Published var description: String = ""
        @Published var image: String = ""
        @Published var questions: [Question] = []
        @Published var errorText: String = ""
        
        func addQuestion(text: String, hint: String?, answer: String, variants: [String]) {
            let question = Question(text: text, hint: hint, answer: answer, variants: variants)
            questions.append(question)
        }
        
        func saveTopic() async {            
            let topicData: [String: Any] = [
                "name": name,
                "description": description,
                "image": image,
                "questions": questions.map { [
                    "text": $0.text,
                    "hint": $0.hint ?? "",
                    "answer": $0.answer,
                    "variants": $0.variants
                ] }
            ]
            
            do {
                guard let user = Auth.auth().currentUser else { return }
                                
                let userId = user.uid
                
                try await Firestore.firestore().collection("users").document(userId).collection("topics").addDocument(data: topicData)
            } catch {
                self.errorText = error.localizedDescription
                print(error.localizedDescription)
            }
        }
    }
}
