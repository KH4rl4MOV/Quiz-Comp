//
//  RouterView.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

import SwiftUI

struct RouterView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        NavigationStack {
            switch appViewModel.status {
            case .login:
                LoginView()
            case .onboarding:
                EmptyView()
            case .main:
                HomeView()
            }
        }
    }
}

#Preview {
    RouterView()
}
