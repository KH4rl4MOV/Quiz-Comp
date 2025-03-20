//
//  ProfileView.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 14.02.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ViewModel()
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
            
            Image(.profileIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Spacer()
            
            if viewModel.isAnonymous {
                Text("Log in to your account to add and save your questions")
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .font(.system(.title2, design: .rounded))
                    .padding(.horizontal)
                    .bold()
            } else {
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .font(.system(.title, design: .rounded))
                        .bold()

                }
                
                Spacer()
                
                CellView(text: "Delete account")
                    .onTapGesture {
                        viewModel.showPasswordAlert = true
                    }
                    .padding(.bottom, 30)
            }
            
            CellView(text: "Sign out")
                .onTapGesture {
                    Task {
                        do {
                            try viewModel.logOut()
                            isLogin = false
                            appViewModel.status = .login
                            dismiss()
                        } catch {
                            viewModel.errorMessage = error.localizedDescription
                        }
                    }
                }
                .padding(.bottom, 50)
            
            Spacer()
        }
        .onAppear {
            viewModel.fetchUserProfile()
        }
        .alert("Enter Password", isPresented: $viewModel.showPasswordAlert) {
            SecureField("Password", text: $viewModel.password)
            Button("Delete", action: {
                Task {
                    do {
                        try await viewModel.reauthenticateAndDeleteAccount(password: viewModel.password) { result in
                            switch result {
                            case .success:
                                isLogin = false
                                appViewModel.status = .login
                                dismiss()
                                print("Account deleted successfully")
                            case .failure(let error):
                                viewModel.errorMessage = error.localizedDescription
                                viewModel.showPasswordAlert = true
                            }
                        }
                    } catch {
                        viewModel.errorMessage = error.localizedDescription
                        viewModel.showPasswordAlert = true
                    }
                }
            })
            Button("Cancel", role: .cancel, action: {})
        } message: {
            Text(viewModel.errorMessage)
        }
        .background(.back)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ProfileView()
}
