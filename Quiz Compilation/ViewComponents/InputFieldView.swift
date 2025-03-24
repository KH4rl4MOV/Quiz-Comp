//
//  InputFieldView.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

import SwiftUI

struct InputField: View {
    let label: String
    @Binding var text: String
    @State var isSecure = false
    
    var body: some View {
        Group {
            if isSecure {
                VStack {
                    HStack {
                        Text(label)
                            .foregroundStyle(.text)
                            .multilineTextAlignment(.center)
                            .font(.system(.title2, design: .rounded))
                            .bold()
                        Spacer()
                    }
                    
                    Capsule()
                        .foregroundStyle(.text)
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 40)
                        .overlay {
                            SecureField("", text: $text)
                                .autocorrectionDisabled()
                                .autocapitalization(.none)
                                .foregroundStyle(.back)
                                .font(.system(.title3, design: .rounded))
                                .padding(.horizontal)
                                .bold()
                        }
                }
            } else {
                VStack {
                    HStack {
                        Text(label)
                            .foregroundStyle(.text)
                            .multilineTextAlignment(.center)
                            .font(.system(.title2, design: .rounded))
                            .bold()
                        Spacer()
                    }
                    
                    Capsule()
                        .foregroundStyle(.text)
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 40)
                        .overlay {
                            TextField("", text: $text)
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                                .foregroundStyle(.back)
                                .font(.system(.title2, design: .rounded))
                                .padding(.horizontal)
                                .bold()
                        }
                }
            }
        }
    }
}
