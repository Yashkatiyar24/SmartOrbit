import SwiftUI

struct ExamTimerPillView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "clock")
                .font(.system(size: 14, weight: .bold))
            Text(viewModel.timeString)
                .font(.system(size: 16, weight: .bold, design: .monospaced))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(viewModel.timerColor.opacity(0.15))
        .foregroundColor(viewModel.timerColor)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(viewModel.timerColor.opacity(0.3), lineWidth: 1)
        )
    }
}

struct QuestionPaletteView: View {
    let questions: [Question]
    let currentIndex: Int
    let onSelect: (Int) -> Void
    
    private let columns = [
        GridItem(.adaptive(minimum: 45))
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(0..<questions.count, id: \.self) { index in
                Button(action: { onSelect(index) }) {
                    Text("\(index + 1)")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: 44, height: 44)
                        .background(backgroundColor(for: questions[index], isSelected: index == currentIndex))
                        .foregroundColor(foregroundColor(for: questions[index], isSelected: index == currentIndex))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(index == currentIndex ? Color.blue : Color.clear, lineWidth: 2)
                        )
                }
            }
        }
        .padding()
    }
    
    private func backgroundColor(for question: Question, isSelected: Bool) -> Color {
        switch question.status {
        case .unseen:
            return Color(UIColor.systemGray6)
        case .attempted:
            return .green
        case .markedForReview:
            return .purple
        }
    }
    
    private func foregroundColor(for question: Question, isSelected: Bool) -> Color {
        switch question.status {
        case .unseen:
            return .primary
        default:
            return .white
        }
    }
}
