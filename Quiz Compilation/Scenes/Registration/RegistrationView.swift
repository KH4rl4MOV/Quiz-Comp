//
//  RegistrationView.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

import Foundation
import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ViewModel()
    @EnvironmentObject var appViewModel: AppViewModel
    @AppStorage("isLoggedIn") var isLogin = false
    
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
            
            Text("Register")
                .foregroundStyle(.text)
                .multilineTextAlignment(.center)
                .font(.system(.title, design: .rounded))
                .bold()
            
            Image(.registerIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 170)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            ScrollView(showsIndicators: false) {
                VStack {
                    InputField(label: "Email", text: $viewModel.email)
                        .padding(.bottom, 20)
                    InputField(label: "Password", text: $viewModel.password, isSecure: true)
                        .padding(.bottom, 20)
                    InputField(label: "Confirm", text: $viewModel.confirmPass, isSecure: true)
                        .padding(.bottom, 20)
                    
                    if !viewModel.errorText.isEmpty {
                        Text(viewModel.errorText)
                    }
                }
                .padding(.horizontal, 40)
            }
            .ignoresSafeArea(.keyboard)
            
            CellView(text: "Sign Up")
                .onTapGesture {
                    Task {
                        do {
                            try await viewModel.register()
                            isLogin = true
                            appViewModel.status = .main
                            dismiss()
                        } catch {
                            viewModel.errorText = error.localizedDescription
                        }
                    }
                }
                .padding(.vertical, 10)
            
            Spacer()
        }
        .background(.back)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    RegistrationView()
}

