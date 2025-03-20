//
//  MemoryCardView.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 14.02.2025.
//

import SwiftUI

struct MemoryCardView: View {
    var topic: Topic
    @Environment(\.dismiss) var dismiss
    @State var number = 0
    @State var showQuestion = true
    var body: some View {
        VStack {
            HStack {
                Image(.backIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
            }
            
            Text(topic.name)
                .foregroundStyle(.text)
                .multilineTextAlignment(.center)
                .font(.system(.title, design: .rounded))
                .bold()
            
            Spacer()
            
            CardView(question: topic.questions[number].text, answer: topic.questions[number].answer, showQuestion: $showQuestion)
            
            Spacer()

            HStack {
                CellView(
                    text: "Previous",
                    widthProportion: 0.4,
                    color: number > 0 ? .customBlue : .customBlue.opacity(0.5),
                    foregroundColor: .black
                ).onTapGesture {
                    if number > 0 {
                        withAnimation {
                            showQuestion = true
                            number -= 1
                        }
                    }
                }
                
                CellView(
                    text: "Next",
                    widthProportion: 0.4,
                    color: number < topic.questions.count - 1 ? .customBlue : .customBlue.opacity(0.5),
                    foregroundColor: .black
                ).onTapGesture {
                    if number < topic.questions.count - 1 {
                        withAnimation {
                            showQuestion = true
                            number += 1
                        }
                    }
                }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.back)
        .navigationBarBackButtonHidden()
    }
}
