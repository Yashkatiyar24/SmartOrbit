import Foundation
import SwiftUI

class ExamViewModel: ObservableObject {
    @Published var questions: [Question]
    @Published var currentIndex: Int = 0
    @Published var isExamSubmitted: Bool = false
    
    let timerViewModel: TimerViewModel
    
    init(questions: [Question], duration: TimeInterval) {
        self.questions = questions
        self.timerViewModel = TimerViewModel(duration: duration)
        
        self.timerViewModel.onTimeUp = { [weak self] in
            self?.submitExam()
        }
    }
    
    var currentQuestion: Question {
        questions[currentIndex]
    }
    
    func selectOption(at index: Int) {
        questions[currentIndex].selectedOptionIndex = index
        if questions[currentIndex].status != .markedForReview {
            questions[currentIndex].status = .attempted
        }
    }
    
    func markForReview() {
        questions[currentIndex].status = .markedForReview
    }
    
    func nextQuestion() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
        }
    }
    
    func goToQuestion(at index: Int) {
        if index >= 0 && index < questions.count {
            currentIndex = index
        }
    }
    
    func submitExam() {
        isExamSubmitted = true
        timerViewModel.stop()
    }
    
    // Statistics for the report
    var attemptedCount: Int {
        questions.filter { $0.status == .attempted }.count
    }
    
    var markedReviewCount: Int {
        questions.filter { $0.status == .markedForReview }.count
    }
    
    var unseenCount: Int {
        questions.filter { $0.status == .unseen }.count
    }
}
