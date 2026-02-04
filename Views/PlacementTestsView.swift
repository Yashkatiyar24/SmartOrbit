import SwiftUI

// MARK: - Company Model
struct Company: Identifiable {
    let id = UUID()
    let name: String
    let role: String
    let difficulty: Difficulty
    let iconName: String
    let iconBgColor: Color
    let iconFgColor: Color
    
    enum Difficulty: String {
        case easy = "Easy"
        case medium = "Medium"
        case hard = "Hard"
        
        var color: Color {
            switch self {
            case .easy: return Color(hex: "2ECC71")
            case .medium: return Color(hex: "E67E22")
            case .hard: return Color(hex: "E74C3C")
            }
        }
    }
}

// MARK: - Placement Tests View
struct PlacementTestsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @State private var selectedCompany: Company?
    
    let companies: [Company] = [
        Company(name: "Google", role: "Software Engineer", difficulty: .hard, 
                iconName: "g.circle.fill", iconBgColor: Color(hex: "1A1A1A"), iconFgColor: .white),
        Company(name: "Amazon", role: "SDE - I", difficulty: .hard, 
                iconName: "arrow.up.right", iconBgColor: Color(hex: "1A1A1A"), iconFgColor: Color(hex: "FF9900")),
        Company(name: "Microsoft", role: "Software Engineer", difficulty: .medium, 
                iconName: "square.grid.2x2.fill", iconBgColor: Color(hex: "F0F0F0"), iconFgColor: Color(hex: "00A4EF")),
        Company(name: "TCS", role: "Digital Engineer", difficulty: .medium, 
                iconName: "circle.fill", iconBgColor: Color(hex: "8B7355"), iconFgColor: .white),
        Company(name: "Infosys", role: "Systems Engineer", difficulty: .medium, 
                iconName: "circle.hexagongrid.fill", iconBgColor: Color(hex: "007CC3"), iconFgColor: .white),
        Company(name: "Meta", role: "Software Engineer", difficulty: .hard, 
                iconName: "triangle.fill", iconBgColor: Color(hex: "E8F4F8"), iconFgColor: Color(hex: "0668E1"))
    ]
    
    var filteredCompanies: [Company] {
        if searchText.isEmpty {
            return companies
        }
        return companies.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Search Bar
                    searchBar
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                        .padding(.bottom, 24)
                    
                    // Companies Grid
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        ForEach(filteredCompanies) { company in
                            CompanyCard(company: company) {
                                selectedCompany = company
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
            }
            .background(Color(hex: "F8F9FA"))
            .navigationTitle("Placement Tests")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .fullScreenCover(item: $selectedCompany) { company in
            ExamView(viewModel: ExamViewModel(
                questions: MockData.getCompanyQuestions(for: company.name),
                duration: 3600,
                testType: .campusPlacement
            ))
        }
    }
    
    // MARK: - Search Bar
    var searchBar: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(hex: "8E8E93"))
            
            TextField("Search", text: $searchText)
                .font(.system(size: 17))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(hex: "E5E5EA"), lineWidth: 1)
        )
    }
}

// MARK: - Company Card
struct CompanyCard: View {
    let company: Company
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Company Icon
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(company.iconBgColor)
                    .frame(width: 48, height: 48)
                
                Image(systemName: company.iconName)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(company.iconFgColor)
            }
            .padding(.bottom, 16)
            
            // Company Name
            Text(company.name)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(Color(hex: "1C1C1E"))
                .padding(.bottom, 4)
            
            // Role
            Text(company.role)
                .font(.system(size: 14))
                .foregroundColor(Color(hex: "8E8E93"))
                .padding(.bottom, 12)
            
            // Difficulty Badge
            Text(company.difficulty.rawValue)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(company.difficulty.color)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(company.difficulty.color.opacity(0.12))
                .cornerRadius(8)
                .padding(.bottom, 16)
            
            Spacer()
            
            // Start Test Button
            Button(action: action) {
                Text("Start Test")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color(hex: "3478F6"))
                    .cornerRadius(12)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 240)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 8, y: 2)
    }
}

// MARK: - Mock Data Extension for Company Questions
extension MockData {
    static func getCompanyQuestions(for company: String) -> [Question] {
        // Return company-specific questions
        switch company {
        case "Google":
            return [
                Question(text: "What is the time complexity of binary search?", options: ["O(n)", "O(log n)", "O(n²)", "O(1)"], correctAnswerIndex: 1),
                Question(text: "Which data structure uses LIFO principle?", options: ["Queue", "Stack", "Array", "Linked List"], correctAnswerIndex: 1),
                Question(text: "What is a hash collision?", options: ["Two keys mapping to same index", "Memory overflow", "Syntax error", "None"], correctAnswerIndex: 0),
                Question(text: "Which sorting algorithm has best average case?", options: ["Bubble Sort", "Quick Sort", "Selection Sort", "Insertion Sort"], correctAnswerIndex: 1),
                Question(text: "What is dynamic programming?", options: ["Breaking problems into subproblems", "Using pointers", "Memory allocation", "None"], correctAnswerIndex: 0)
            ]
        case "Amazon":
            return [
                Question(text: "What is AWS S3 used for?", options: ["Computing", "Storage", "Database", "Networking"], correctAnswerIndex: 1),
                Question(text: "What is the CAP theorem?", options: ["Consistency, Availability, Partition tolerance", "Cache, API, Protocol", "None", "All"], correctAnswerIndex: 0),
                Question(text: "What is a microservice?", options: ["Large application", "Small independent service", "Database", "API"], correctAnswerIndex: 1),
                Question(text: "What is load balancing?", options: ["Distributing traffic", "Caching", "Encryption", "Compression"], correctAnswerIndex: 0),
                Question(text: "What is REST API?", options: ["Database", "Architectural style", "Programming language", "Framework"], correctAnswerIndex: 1)
            ]
        default:
            return sampleQuestions
        }
    }
}

// MARK: - Preview
struct PlacementTestsView_Previews: PreviewProvider {
    static var previews: some View {
        PlacementTestsView()
    }
}
