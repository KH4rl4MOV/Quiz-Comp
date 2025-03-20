//
//  AddTopic.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 15.02.2025.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

struct AddTopicView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ViewModel()
    @State private var newQuestionText = ""
    @State private var newHint = ""
    @State private var newAnswer = ""
    @State private var newVariants = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(.backIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
                    .onTapGesture { dismiss() }
                
                Spacer()
            }
            .padding()
            
            ScrollView {
                VStack {
                    InputField(label: "Topic Name", text: $viewModel.name)
                    
                    InputField(label: "Description", text: $viewModel.description)
                    
                    InputField(label: "Image URL", text: $viewModel.image)
                    
                    Divider()
                        .foregroundStyle(.customBlue)
                    
                    Text("Add Questions")
                        .foregroundStyle(.customBlue)
                        .multilineTextAlignment(.center)
                        .font(.system(.title2, design: .rounded))
                        .padding(.horizontal)
                        .bold()
                    
                    InputField(label: "Question Text", text: $newQuestionText)
                    
                    InputField(label: "Hint (optional)", text: $newHint)
                    
                    InputField(label: "Answer", text: $newAnswer)
                    
                    InputField(label: "Variants (comma separated)", text: $newVariants)

                    HStack {
                        Spacer()
                        
                        CellView(
                            text: "Add question",
                            height: 100,
                            color: .customBlue
                        )
                        .onTapGesture {
                            guard !newQuestionText.isEmpty, !newAnswer.isEmpty, !newVariants.isEmpty else {
                                viewModel.errorText = "Fill in all the fields"
                                return
                            }
                            
                            let variantsArray = newVariants.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
                                
                            guard variantsArray.contains(newAnswer) else {
                                viewModel.errorText = "There should be a correct answer in the options field"
                                return
                            }
                            
                            viewModel.addQuestion(text: newQuestionText, hint: newHint.isEmpty ? nil : newHint, answer: newAnswer, variants: variantsArray)
                            newQuestionText = ""
                            newHint = ""
                            newAnswer = ""
                            newVariants = ""
                        }
                        .padding()
                        
                        Spacer()
                    }
                    
                    List(viewModel.questions) { question in
                        VStack(alignment: .leading) {
                            Text(question.text).font(.headline)
                            if let hint = question.hint { Text("Hint: \(hint)").font(.subheadline) }
                            Text("Answer: \(question.answer)")
                            Text("Variants: \(question.variants.joined(separator: ", "))")
                        }
                        .foregroundStyle(.back)
                        .font(.system(.subheadline, design: .rounded))
                        .padding(.horizontal)
                        .bold()
                    }
                    .scrollContentBackground(.hidden)
                    .listRowBackground(Color.clear)
                    .frame(height: 200)
                }
                .padding(.horizontal, 40)
            }
            
            if !viewModel.errorText.isEmpty {
                Text(viewModel.errorText)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .font(.system(.title3, design: .rounded))
                    .padding(.horizontal)
                    .bold()
            }
            
            CellView(
                text: "Save Topic",
                height: 100,
                color: .customBlue
            )
            .onTapGesture {
                guard !viewModel.name.isEmpty, !viewModel.description.isEmpty, !viewModel.questions.isEmpty else {
                    viewModel.errorText = "Fill in all fields and add at least one question"
                    return
                }
                                    
                Task { await viewModel.saveTopic() }
                dismiss()
            }
            .padding()
        }
        .background(.back)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AddTopicView()
}
