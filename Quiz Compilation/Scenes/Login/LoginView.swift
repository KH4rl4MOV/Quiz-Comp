//
//  LoginView.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

import SwiftUI

struct LoginView: View {
    @AppStorage("isLoggedIn") var isLogin = false
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {            
            Text("Login")
                .foregroundStyle(.text)
                .multilineTextAlignment(.center)
                .font(.system(.title, design: .rounded))
                .padding(.vertical, 20)
                .bold()
            
            Spacer()
            
            Image(.loginIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 170)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Spacer()
            
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        InputField(label: "Email", text: $viewModel.email)
                            .padding(.bottom, 50)
                        
                        InputField(label: "Password", text: $viewModel.password, isSecure: true)
                            .padding(.bottom, 10)
                        
                        HStack {
                            Text("Registration")
                                .foregroundStyle(.customBlue)
                                .multilineTextAlignment(.center)
                                .font(.system(.footnote, design: .rounded))
                                .bold()
                                .onTapGesture {
                                    viewModel.goToRegistration.toggle()
                                }
                            
                            Spacer()
                            
                            Text("Log in anonymously")
                                .foregroundStyle(.customBlue)
                                .multilineTextAlignment(.center)
                                .font(.system(.footnote, design: .rounded))
                                .bold()
                                .onTapGesture {
                                    appViewModel.signInAnonymously()
                                }
                        }
                        .padding(.horizontal, 10)
                        
                        HStack {
                            Text(viewModel.errorText)
                                .foregroundStyle(.red)
                                .multilineTextAlignment(.center)
                                .font(.system(.footnote, design: .rounded))
                                .bold()
                        }
                    }
                    .padding(.horizontal, 40)
                }
            }
            
            Spacer()
            
            CellView(text: "Login")
                .onTapGesture {
                    Task {
                        do {
                            try await viewModel.signIn()
                            isLogin = true
                            appViewModel.status = .main
                            dismiss()
                        } catch {
                            viewModel.errorText = error.localizedDescription
                        }
                    }
                }
                .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.back)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
        .navigationDestination(isPresented: $viewModel.goToRegistration) {
            RegistrationView()
        }
    }
}

#Preview {
    LoginView()
}
