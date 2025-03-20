//
//  CardView.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 14.02.2025.
//

import SwiftUI

struct CardView: View {
    var question: String
    var answer: String
    @Binding var showQuestion: Bool
    var body: some View {
        Group {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.card)
                .overlay {
                    Text(showQuestion ? question : answer)
                        .foregroundStyle(.white)
                        .font(.system(.title, design: .rounded))
                        .bold()
                        .padding(.horizontal, 5)
                        .rotation3DEffect(showQuestion ? .zero : .degrees(180),
                                          axis: showQuestion ?
                                          (x: 0.0, y: 0.0, z: 0.0) :
                                            (x: 1.0, y: 0.0, z: 0.0),
                                          anchor: .center
                        )
                }
                .frame(
                    width: UIScreen.main.bounds.width * 0.8,
                    height: UIScreen.main.bounds.height * 0.6
                )
                .colorScheme(.dark)
            
        }
        .rotation3DEffect(showQuestion ? .zero : .degrees(180),
                          axis: showQuestion ?
                          (x: 0.0, y: 0.0, z: 0.0) :
                            (x: 1.0, y: 0.0, z: 0.0),
                          anchor: .center
        )
        .onTapGesture {
            withAnimation(.bouncy(duration: 1.5)) {
                showQuestion.toggle()
            }
        }
    }
}
