//
//  ContentView.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 14.02.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink {
                    MemorizationView()
                } label: {
                    CellView(
                        text: "Memorization",
                        widthProportion: 0.5,
                        color: .turquoise,
                        foregroundColor: .black
                    )
                }
                
                NavigationLink {
                    ProfileView()
                } label: {
                    CellView(
                        text: "Profile",
                        widthProportion: 0.3,
                        color: .customBlue,
                        foregroundColor: .black
                    )
                }
            }
            
            HStack {
                NavigationLink {
                    LibraryView()
                } label: {
                    CellView(
                        text: "Library",
                        widthProportion: 0.3,
                        color: .customBlue,
                        foregroundColor: .black
                    )
                }
                
                NavigationLink {
                    TestMenuView()
                } label: {
                    CellView(
                        text: "Test",
                        widthProportion: 0.5,
                        color: .turquoise,
                        foregroundColor: .black
                    )
                }
            }
            
            VStack {
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.topics) { topic in
                        CellImageView(
                            text: topic.name,
                            url: topic.image,
                            widthProportion: 0.9
                        )
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.back)
    }
}

#Preview {
    HomeView()
}
