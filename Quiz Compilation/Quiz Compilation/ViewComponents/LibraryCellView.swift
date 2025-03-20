//
//  LibraryCellView.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

import SwiftUI

struct LibraryCell: View {
    var text: String
    var url: String?
    var widthProportion: Double = 0.8
    var hightProportion: Double = 0.3
    var height: CGFloat?
    var color: Color = .card
    var foregroundColor: Color = .white
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(color)
            .overlay {
                HStack {
                    Text(text)
                        .foregroundStyle(foregroundColor)
                        .multilineTextAlignment(.center)
                        .font(.system(.title2, design: .rounded))
                        .bold()
                    
                    Spacer()
                    
                    if let url, !url.isEmpty {
                        AsyncImage(url: URL(string: url)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            case .failure(let error):
                                Image(.quizIcon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image(.quizIcon)
                            .resizable()
                            .scaledToFit()
                            .padding(.vertical)
                            .frame(height: 100)
                    }
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width * widthProportion, height: 100)
            .colorScheme(.dark)
    }
}

#Preview {
    LibraryCell(text: "Text")
}
