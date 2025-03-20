//
//  TestView.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

import SwiftUI

struct TestView: View {
    @State private var number = 0
    @State private var showMessage = false
    @State private var wrongAnswerMessage = "Wrong answer, try again"
    @State private var showFinishMessage = false
    @State private var finishMessage = "Take the test again or choose a new one"
    @State var topic: Topic
    @Environment(\.dismiss) var dismiss

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
            
            Text(topic.questions[number].text)
                .foregroundStyle(.text)
                .multilineTextAlignment(.center)
                .font(.system(.title2, design: .rounded))
                .padding(.horizontal)
                .opacity(showFinishMessage ? 0 : 1)
                .bold()
            
            Text(wrongAnswerMessage)
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
                .font(.system(.title2, design: .rounded))
                .opacity(showMessage ? 1 : 0)
                .bold()
            
            if showFinishMessage {
                Spacer()
                CellView(
                    text: "Take the test again",
                    widthProportion: 0.8,
                    color: .customBlue
                ).onTapGesture {
                    withAnimation {
                        number = 0
                        showFinishMessage = false
                    }
                }
                
                CellView(
                    text: "Go back to all the tests",
                    widthProportion: 0.8,
                    color: .turquoise
                ).onTapGesture {
                    dismiss()
                }
                
                Spacer()
                
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(topic.questions[number].variants.shuffled().enumerated().map({ $0 }), id: \.offset) { index, variant in
                        CellView(
                            text: topic.questions[number].variants[index],
                            widthProportion: 0.8,
                            color: index.isMultiple(of: 2) ? .customBlue : .turquoise
                        ).onTapGesture {
                            if topic.questions[number].variants[index] == topic.questions[number].answer {
                                if number < topic.questions.count - 1 {
                                    withAnimation {
                                        number += 1
                                        showMessage = false
                                    }
                                } else {
                                    withAnimation {
                                        showFinishMessage = true
                                        showMessage = false
                                    }
                                }
                            } else {
                                showMessage = true
                            }
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

