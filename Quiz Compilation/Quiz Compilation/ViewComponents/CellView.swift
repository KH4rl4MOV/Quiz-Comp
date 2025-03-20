//
//  CellView.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 14.02.2025.
//

import SwiftUI

struct CellView: View {
    var text: String
    var widthProportion: Double = 0.5
    var hightProportion: Double = 0.1
    var height: CGFloat?
    var color: Color = .card
    var foregroundColor: Color = .white
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(color)
            .overlay {
                Text(text)
                    .foregroundStyle(foregroundColor)
                    .multilineTextAlignment(.center)
                    .font(.system(.title2, design: .rounded))
                    .bold()
            }
            .frame(
                width: UIScreen.main.bounds.width * widthProportion,
                height: height == nil ?
                UIScreen.main.bounds.height * hightProportion :
                    height
            )
            .colorScheme(.dark)
            .padding(5)
    }
}

#Preview {
    CellView(text: "Text")
}
