//
//  LibraryView.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 14.02.2025.
//

import SwiftUI

struct LibraryView: View {
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
                
                if !viewModel.isAnonymous {
                    Image(.plusIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 45)
                        .padding(.trailing)
                        .onTapGesture {
                            viewModel.goToAddTopic.toggle()
                        }
                }
            }
            
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.topics) { topic in
                    LibraryCell(
                        text: topic.name,
                        url: topic.image,
                        widthProportion: 0.9
                    )
                }
            }
            Spacer()
        }
        .navigationDestination(isPresented: $viewModel.goToAddTopic) {
            AddTopicView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.back)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LibraryView()
}
