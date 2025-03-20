//
//  CellImageView.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 14.02.2025.
//

import SwiftUI

struct CellImageView: View {
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
                VStack {
                    HStack {
                        Text(text)
                            .foregroundStyle(foregroundColor)
                            .multilineTextAlignment(.center)
                            .font(.system(.title2, design: .rounded))
                            .bold()
                        Spacer()
                    }
                    .padding()
                    
                    if let url, !url.isEmpty {
                        AsyncImage(url: URL(string: url)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            case .failure(let error):
                                Image(.quizIcon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image(.quizIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width * widthProportion, height: 300)
            .colorScheme(.dark)
    }
    
}

#Preview {
    CellImageView(text: "Text")
}
