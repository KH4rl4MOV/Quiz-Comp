//
//  HomeViewModel.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 14.02.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension HomeView {
    @MainActor
    class ViewModel: ObservableObject {
        private let db = Firestore.firestore()
        
        var topicManager = TopicManager()
        @Published var topics: [Topic] = []

        init() {
            Task {
                await loadTopics()
            }
            observeTopics()
        }
        
        func loadTopics() async {
            self.topics = await topicManager.loadTopics()
        }
        
        func observeTopics() {
            guard let user = Auth.auth().currentUser else { return }
            let userId = user.uid

            db.collection("users").document(userId).collection("topics").addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Ошибка загрузки данных: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                DispatchQueue.main.async {
                    self.topics = documents.compactMap { document in
                        let data = document.data()
                        
                        guard let name = data["name"] as? String,
                              let description = data["description"] as? String,
                              let image = data["image"] as? String,
                              let questionsData = data["questions"] as? [[String: Any]] else { return nil }
                        
                        let questions = questionsData.compactMap { qData -> Question? in
                            guard let text = qData["text"] as? String,
                                  let answer = qData["answer"] as? String,
                                  let variants = qData["variants"] as? [String] else { return nil }
                            
                            let hint = qData["hint"] as? String
                            return Question(text: text, hint: hint, answer: answer, variants: variants)
                        }
                        
                        return Topic(name: name, description: description, image: image, questions: questions)
                    } + self.topicManager.defaultTopics
                }
            }
        }
    }
}
