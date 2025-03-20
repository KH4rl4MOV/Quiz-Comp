//
//  TestViewModel.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

import Foundation

extension TestMenuView {
    @MainActor
    class ViewModel: ObservableObject {
        var topicManager = TopicManager()
        @Published var topics: [Topic] = []
        
        init() {
            Task {
                await loadTopics()
            }
        }
        
        func loadTopics() async {
            self.topics = await topicManager.loadTopics()
        }
    }
}
