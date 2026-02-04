import SwiftUI

// MARK: - Design System (Apple HIG)
// ================================
// Primary Color: #3478F6 (iOS Blue)
// Background: #F8F9FA (Light Gray)
// Card Background: #FFFFFF
// Text Primary: #1C1C1E
// Text Secondary: #8E8E93
// Horizontal Padding: 20pt
// Vertical Section Spacing: 32pt
// Card Corner Radius: 16pt
// Card Internal Padding: 16pt

struct MainTabView: View {
    @State private var selectedTab = 0
    
    init() {
        // Customize tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                    Text("Home")
                }
                .tag(0)
            
            AllTestsView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "doc.text.fill" : "doc.text")
                    Text("Tests")
                }
                .tag(1)
            
            AnalyticsView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "chart.bar.fill" : "chart.bar")
                    Text("Analytics")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "person.fill" : "person")
                    Text("Profile")
                }
                .tag(3)
        }
        .accentColor(Color(hex: "3478F6"))
    }
}

// MARK: - Home View (Redesigned with Apple HIG)
struct HomeView: View {
    @State private var showPlacementTests = false
    @State private var showGATETests = false
    @State private var showJEETests = false
    @State private var showNEETTests = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                // Header Section
                headerSection
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 32)
                
                // Stats Card
                statsCard
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                
                // Placement & Higher Studies
                sectionHeader("Placement & Higher Studies")
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                
                HStack(spacing: 16) {
                    CategoryCard(
                        icon: "building.2.fill",
                        iconColor: Color(hex: "3478F6"),
                        title: "Campus\nPlacement",
                        subtitle: "Prepare for top companies",
                        buttonColor: Color(hex: "3478F6"),
                        action: { showPlacementTests = true }
                    )
                    
                    CategoryCard(
                        icon: "graduationcap.fill",
                        iconColor: Color(hex: "AF52DE"),
                        title: "GATE",
                        subtitle: "Master engineering concepts",
                        buttonColor: Color(hex: "AF52DE"),
                        action: { showGATETests = true }
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
                
                // Undergraduate Entrance
                sectionHeader("Undergraduate Entrance")
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                
                HStack(spacing: 16) {
                    CategoryCard(
                        icon: "flask.fill",
                        iconColor: Color(hex: "FF9500"),
                        title: "JEE",
                        subtitle: "Ace JEE Main & Advanced",
                        buttonColor: Color(hex: "FF9500"),
                        action: { showJEETests = true }
                    )
                    
                    CategoryCard(
                        icon: "heart.fill",
                        iconColor: Color(hex: "34C759"),
                        title: "NEET",
                        subtitle: "Excel in medical entrance",
                        buttonColor: Color(hex: "34C759"),
                        action: { showNEETTests = true }
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
        .background(Color(hex: "F8F9FA"))
        .fullScreenCover(isPresented: $showPlacementTests) {
            PlacementTestsView()
        }
        .fullScreenCover(isPresented: $showGATETests) {
            GATETestsView()
        }
        .fullScreenCover(isPresented: $showJEETests) {
            JEETestsView()
        }
        .fullScreenCover(isPresented: $showNEETTests) {
            NEETTestsView()
        }
    }
    
    // MARK: - Header Section
    var headerSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Welcome back,")
                    .font(.system(size: 15))
                    .foregroundColor(Color(hex: "8E8E93"))
                
                Text("Alex")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(hex: "1C1C1E"))
            }
            
            Spacer()
            
            // Notification Button
            Button(action: {}) {
                ZStack(alignment: .topTrailing) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 44, height: 44)
                        .shadow(color: Color.black.opacity(0.06), radius: 8, y: 2)
                    
                    Image(systemName: "bell")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(Color(hex: "1C1C1E"))
                        .frame(width: 44, height: 44)
                    
                    // Notification Badge
                    Circle()
                        .fill(Color(hex: "FF3B30"))
                        .frame(width: 8, height: 8)
                        .offset(x: -10, y: 10)
                }
            }
        }
    }
    
    // MARK: - Stats Card
    var statsCard: some View {
        HStack(spacing: 0) {
            StatItemView(
                icon: "calendar.badge.clock",
                iconColor: Color(hex: "3478F6"),
                value: "24",
                label: "Tests Taken"
            )
            
            // Subtle Divider
            Rectangle()
                .fill(Color(hex: "E5E5EA"))
                .frame(width: 1, height: 48)
            
            StatItemView(
                icon: "chart.line.uptrend.xyaxis",
                iconColor: Color(hex: "34C759"),
                value: "78%",
                label: "Avg Score"
            )
            
            // Subtle Divider
            Rectangle()
                .fill(Color(hex: "E5E5EA"))
                .frame(width: 1, height: 48)
            
            StatItemView(
                icon: "trophy.fill",
                iconColor: Color(hex: "FFCC00"),
                value: "12",
                label: "Rank"
            )
        }
        .padding(.vertical, 24)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 12, y: 4)
    }
    
    // MARK: - Section Header
    func sectionHeader(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color(hex: "1C1C1E"))
            Spacer()
        }
    }
}

// MARK: - Stat Item View
struct StatItemView: View {
    let icon: String
    let iconColor: Color
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(iconColor)
            
            Text(value)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color(hex: "1C1C1E"))
            
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(Color(hex: "8E8E93"))
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Category Card (Apple HIG Style)
struct CategoryCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let buttonColor: Color
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Icon with subtle background
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(iconColor.opacity(0.12))
                    .frame(width: 48, height: 48)
                
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(iconColor)
            }
            .padding(.bottom, 16)
            
            // Title
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(Color(hex: "1C1C1E"))
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 6)
            
            // Subtitle
            Text(subtitle)
                .font(.system(size: 14))
                .foregroundColor(Color(hex: "8E8E93"))
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
            
            // Start Test Button
            Button(action: action) {
                Text("Start Test")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(buttonColor)
                    .cornerRadius(12)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .frame(height: 220)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 12, y: 4)
    }
}

// MARK: - All Tests View
struct AllTestsView: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(TestCategory.allCases, id: \.self) { category in
                        TestListRow(category: category)
                    }
                }
                .padding(20)
            }
            .background(Color(hex: "F8F9FA"))
            .navigationTitle("All Tests")
        }
    }
}

enum TestCategory: String, CaseIterable {
    case campusPlacement = "Campus Placement"
    case gate = "GATE"
    case jee = "JEE"
    case neet = "NEET"
    
    var icon: String {
        switch self {
        case .campusPlacement: return "building.2.fill"
        case .gate: return "graduationcap.fill"
        case .jee: return "flask.fill"
        case .neet: return "heart.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .campusPlacement: return Color(hex: "3478F6")
        case .gate: return Color(hex: "AF52DE")
        case .jee: return Color(hex: "FF9500")
        case .neet: return Color(hex: "34C759")
        }
    }
    
    var questionsCount: Int {
        switch self {
        case .campusPlacement: return 50
        case .gate: return 65
        case .jee: return 75
        case .neet: return 180
        }
    }
    
    var duration: String {
        switch self {
        case .campusPlacement: return "60 mins"
        case .gate: return "180 mins"
        case .jee: return "180 mins"
        case .neet: return "200 mins"
        }
    }
}

struct TestListRow: View {
    let category: TestCategory
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(category.color.opacity(0.12))
                    .frame(width: 48, height: 48)
                
                Image(systemName: category.icon)
                    .font(.system(size: 20))
                    .foregroundColor(category.color)
            }
            
            // Info
            VStack(alignment: .leading, spacing: 4) {
                Text(category.rawValue)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(hex: "1C1C1E"))
                
                Text("\(category.questionsCount) Questions • \(category.duration)")
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "8E8E93"))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(hex: "C7C7CC"))
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
    }
}

// MARK: - Analytics View
struct AnalyticsView: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Performance Card
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Performance Overview")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color(hex: "1C1C1E"))
                        
                        HStack(spacing: 20) {
                            PerformanceMetric(title: "Tests", value: "24", trend: "+3")
                            PerformanceMetric(title: "Avg Score", value: "78%", trend: "+5%")
                            PerformanceMetric(title: "Rank", value: "#12", trend: "↑4")
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(16)
                    
                    // Recent Results
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recent Results")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(Color(hex: "1C1C1E"))
                        
                        ForEach(0..<4, id: \.self) { index in
                            ResultRow(
                                testName: ["JEE Mock #5", "NEET Practice", "GATE CS", "Google Prep"][index],
                                score: [85, 72, 68, 92][index],
                                date: ["Jan 28", "Jan 25", "Jan 20", "Jan 15"][index]
                            )
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(16)
                }
                .padding(20)
            }
            .background(Color(hex: "F8F9FA"))
            .navigationTitle("Analytics")
        }
    }
}

struct PerformanceMetric: View {
    let title: String
    let value: String
    let trend: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 13))
                .foregroundColor(Color(hex: "8E8E93"))
            
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(hex: "1C1C1E"))
            
            Text(trend)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(Color(hex: "34C759"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ResultRow: View {
    let testName: String
    let score: Int
    let date: String
    
    var scoreColor: Color {
        if score >= 80 { return Color(hex: "34C759") }
        else if score >= 60 { return Color(hex: "FF9500") }
        else { return Color(hex: "FF3B30") }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(testName)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(Color(hex: "1C1C1E"))
                
                Text(date)
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "8E8E93"))
            }
            
            Spacer()
            
            // Score Badge
            Text("\(score)%")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(scoreColor)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(scoreColor.opacity(0.12))
                .cornerRadius(8)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Profile View
struct ProfileView: View {
    @State private var showLogoutAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Profile Header
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color(hex: "3478F6"), Color(hex: "5856D6")],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 88, height: 88)
                            
                            Text("A")
                                .font(.system(size: 36, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        
                        VStack(spacing: 4) {
                            Text("Alex")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(Color(hex: "1C1C1E"))
                            
                            Text("alex@example.com")
                                .font(.system(size: 15))
                                .foregroundColor(Color(hex: "8E8E93"))
                        }
                    }
                    .padding(.top, 20)
                    
                    // Stats Row
                    HStack(spacing: 0) {
                        ProfileStatItem(value: "24", label: "Tests")
                        
                        Rectangle()
                            .fill(Color(hex: "E5E5EA"))
                            .frame(width: 1, height: 40)
                        
                        ProfileStatItem(value: "78%", label: "Average")
                        
                        Rectangle()
                            .fill(Color(hex: "E5E5EA"))
                            .frame(width: 1, height: 40)
                        
                        ProfileStatItem(value: "#12", label: "Rank")
                    }
                    .padding(.vertical, 20)
                    .background(Color.white)
                    .cornerRadius(16)
                    
                    // Menu Items
                    VStack(spacing: 0) {
                        ProfileMenuRow(icon: "person.fill", title: "Edit Profile", color: Color(hex: "3478F6"))
                        Divider().padding(.leading, 56)
                        ProfileMenuRow(icon: "bell.fill", title: "Notifications", color: Color(hex: "FF9500"))
                        Divider().padding(.leading, 56)
                        ProfileMenuRow(icon: "lock.fill", title: "Privacy", color: Color(hex: "34C759"))
                        Divider().padding(.leading, 56)
                        ProfileMenuRow(icon: "questionmark.circle.fill", title: "Help & Support", color: Color(hex: "AF52DE"))
                        Divider().padding(.leading, 56)
                        
                        Button(action: { showLogoutAlert = true }) {
                            HStack(spacing: 16) {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color(hex: "FF3B30"))
                                    .frame(width: 24)
                                
                                Text("Logout")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color(hex: "FF3B30"))
                                
                                Spacer()
                            }
                            .padding(16)
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                }
                .padding(20)
            }
            .background(Color(hex: "F8F9FA"))
            .navigationTitle("Profile")
            .alert("Logout", isPresented: $showLogoutAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Logout", role: .destructive) {}
            } message: {
                Text("Are you sure you want to logout?")
            }
        }
    }
}

struct ProfileStatItem: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color(hex: "1C1C1E"))
            
            Text(label)
                .font(.system(size: 13))
                .foregroundColor(Color(hex: "8E8E93"))
        }
        .frame(maxWidth: .infinity)
    }
}

struct ProfileMenuRow: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(color)
                .frame(width: 24)
            
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(Color(hex: "1C1C1E"))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(hex: "C7C7CC"))
        }
        .padding(16)
    }
}

// MARK: - GATE, JEE, NEET Test Views
struct GATETestsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(["Computer Science", "Electronics", "Mechanical", "Civil"], id: \.self) { subject in
                        SubjectCard(name: subject, questionCount: 65, duration: "3 hours")
                    }
                }
                .padding(20)
            }
            .background(Color(hex: "F8F9FA"))
            .navigationTitle("GATE Tests")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
            }
        }
    }
}

struct JEETestsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(["Physics", "Chemistry", "Mathematics"], id: \.self) { subject in
                        SubjectCard(name: subject, questionCount: 25, duration: "1 hour")
                    }
                }
                .padding(20)
            }
            .background(Color(hex: "F8F9FA"))
            .navigationTitle("JEE Tests")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
            }
        }
    }
}

struct NEETTestsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(["Biology", "Physics", "Chemistry"], id: \.self) { subject in
                        SubjectCard(name: subject, questionCount: 45, duration: "1.5 hours")
                    }
                }
                .padding(20)
            }
            .background(Color(hex: "F8F9FA"))
            .navigationTitle("NEET Tests")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
            }
        }
    }
}

struct SubjectCard: View {
    let name: String
    let questionCount: Int
    let duration: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color(hex: "1C1C1E"))
                
                Text("\(questionCount) Questions • \(duration)")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "8E8E93"))
            }
            
            Spacer()
            
            Button(action: {}) {
                Text("Start")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color(hex: "3478F6"))
                    .cornerRadius(8)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
    }
}

// MARK: - Test Type Enum
enum TestType: String, Identifiable, CaseIterable {
    case campusPlacement = "Campus Placement"
    case gate = "GATE"
    case jee = "JEE"
    case neet = "NEET"
    
    var id: String { rawValue }
}

// MARK: - Mock Data
struct MockData {
    static let sampleQuestions = [
        Question(text: "What is the primary function of a transistor in a circuit?", options: ["Amplification", "Rectification", "Filtration", "Insulation"], correctAnswerIndex: 0),
        Question(text: "Which of the following is a non-renewable source of energy?", options: ["Solar", "Wind", "Natural Gas", "Hydroelectric"], correctAnswerIndex: 2),
        Question(text: "In computer science, what does 'FIFO' stand for?", options: ["Fast In Fast Out", "First In First Out", "First In Final Out", "Fast In Final Out"], correctAnswerIndex: 1),
        Question(text: "What is the SI unit of electric current?", options: ["Volt", "Ohm", "Ampere", "Watt"], correctAnswerIndex: 2),
        Question(text: "Which protocol is used for sending emails?", options: ["HTTP", "FTP", "SMTP", "SNMP"], correctAnswerIndex: 2)
    ]
    
    static func getQuestions(for testType: TestType) -> [Question] {
        return sampleQuestions
    }
}

// MARK: - Preview
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
