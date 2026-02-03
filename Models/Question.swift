import Foundation

enum QuestionStatus: String, Codable {
    case unseen
    case attempted
    case markedForReview
}

struct Question: Identifiable, Codable {
    let id: UUID
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
    var selectedOptionIndex: Int?
    var status: QuestionStatus
    
    init(id: UUID = UUID(), text: String, options: [String], correctAnswerIndex: Int) {
        self.id = id
        self.text = text
        self.options = options
        self.correctAnswerIndex = correctAnswerIndex
        self.selectedOptionIndex = nil
        self.status = .unseen
    }
}
