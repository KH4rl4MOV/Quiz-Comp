//
//  MemorizationView.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 14.02.2025.
//

import SwiftUI

struct MemorizationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ViewModel()

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
            
            VStack {
                Text("Choose a topic to memorize")
                    .foregroundStyle(.text)
                    .multilineTextAlignment(.center)
                    .font(.system(.title, design: .rounded))
                    .bold()
                
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.topics) { topic in
                        NavigationLink {
                            MemoryCardView(topic: topic)
                        } label: {
                            CellImageView(
                                text: topic.name,
                                url: topic.image,
                                widthProportion: 0.9
                            )
                        }
                    }
                }
            }
            
            Spacer()
        }
        .background(.back)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MemorizationView()
}
