import SwiftUI

struct ExamView: View {
    @StateObject var viewModel: ExamViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Minimal Top Bar
            HStack {
                Text("Engineering Practice Mock")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                ExamTimerPillView(viewModel: viewModel.timerViewModel)
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .shadow(color: Color.black.opacity(0.05), radius: 5, y: 2)
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    // Left Side: Question Content
                    VStack(alignment: .leading, spacing: 20) {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 24) {
                                HStack {
                                    Text("Question \(viewModel.currentIndex + 1)")
                                        .font(.subheadline.bold())
                                        .foregroundColor(.blue)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(Color.blue.opacity(0.1))
                                        .cornerRadius(6)
                                    
                                    Spacer()
                                }
                                
                                Text(viewModel.currentQuestion.text)
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .lineSpacing(4)
                                
                                VStack(spacing: 12) {
                                    ForEach(0..<viewModel.currentQuestion.options.count, id: \.self) { index in
                                        OptionRow(
                                            text: viewModel.currentQuestion.options[index],
                                            isSelected: viewModel.currentQuestion.selectedOptionIndex == index,
                                            action: { viewModel.selectOption(at: index) }
                                        )
                                    }
                                }
                            }
                            .padding()
                        }
                        
                        // Bottom Controls
                        HStack(spacing: 16) {
                            Button(action: viewModel.markForReview) {
                                Text("Mark for Review")
                                    .font(.subheadline.bold())
                                    .foregroundColor(.purple)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.purple.opacity(0.1))
                                    .cornerRadius(12)
                            }
                            
                            Button(action: viewModel.nextQuestion) {
                                Text("Next Question")
                                    .font(.subheadline.bold())
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.blue)
                                    .cornerRadius(12)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.systemBackground))
                    }
                    .frame(width: geometry.size.width * 0.7)
                    
                    // Right Side: Palette (Sidebar style for professional exam look)
                    VStack(spacing: 0) {
                        Text("Question Palette")
                            .font(.subheadline.bold())
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                        
                        ScrollView {
                            QuestionPaletteView(
                                questions: viewModel.questions,
                                currentIndex: viewModel.currentIndex,
                                onSelect: { viewModel.goToQuestion(at: $0) }
                            )
                        }
                        
                        Spacer()
                        
                        Button(action: { viewModel.submitExam() }) {
                            Text("Submit Exam")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(12)
                                .padding()
                        }
                    }
                    .frame(width: geometry.size.width * 0.3)
                    .background(Color(UIColor.secondarySystemBackground).opacity(0.5))
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.timerViewModel.start()
        }
        .sheet(isPresented: $viewModel.isExamSubmitted) {
            ReportView(viewModel: viewModel)
        }
    }
}

struct OptionRow: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .stroke(isSelected ? Color.blue : Color.secondary.opacity(0.3), lineWidth: 2)
                        .frame(width: 24, height: 24)
                    
                    if isSelected {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 14, height: 14)
                    }
                }
                
                Text(text)
                    .foregroundColor(.primary)
                    .font(.body)
                
                Spacer()
            }
            .padding()
            .background(isSelected ? Color.blue.opacity(0.05) : Color.clear)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.blue.opacity(0.3) : Color.secondary.opacity(0.1), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
