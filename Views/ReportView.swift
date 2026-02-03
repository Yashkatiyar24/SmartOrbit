import SwiftUI

struct ReportView: View {
    @ObservedObject var viewModel: ExamViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    // Score Card
                    VStack(spacing: 16) {
                        Text("Exam Completed")
                            .font(.title2.bold())
                        
                        Text("Here is your performance summary")
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: 40) {
                            StatCircle(label: "Attempted", count: viewModel.attemptedCount, color: .green)
                            StatCircle(label: "In Review", count: viewModel.markedReviewCount, color: .purple)
                            StatCircle(label: "Unseen", count: viewModel.unseenCount, color: .gray)
                        }
                        .padding(.vertical)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.secondarySystemBackground).cornerRadius(20))
                    
                    // Detailed List (Optional)
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Question Status")
                            .font(.headline)
                        
                        ForEach(0..<viewModel.questions.count, id: \.self) { index in
                            HStack {
                                Text("Question \(index + 1)")
                                Spacer()
                                StatusTag(status: viewModel.questions[index].status)
                            }
                            .padding()
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.02), radius: 2)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Reports")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct StatCircle: View {
    let label: String
    let count: Int
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .stroke(color.opacity(0.2), lineWidth: 4)
                    .frame(width: 60, height: 60)
                
                Text("\(count)")
                    .font(.title3.bold())
                    .foregroundColor(color)
            }
            
            Text(label)
                .font(.caption.bold())
                .foregroundColor(.secondary)
        }
    }
}

struct StatusTag: View {
    let status: QuestionStatus
    
    var body: some View {
        Text(status.rawValue.capitalized)
            .font(.caption2.bold())
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.1))
            .foregroundColor(color)
            .cornerRadius(4)
    }
    
    private var color: Color {
        switch status {
        case .unseen: return .gray
        case .attempted: return .green
        case .markedForReview: return .purple
        }
    }
}
