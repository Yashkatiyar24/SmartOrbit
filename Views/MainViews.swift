import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }
                .tag(0)
            
            ReportsOverviewView()
                .tabItem {
                    Label("Reports", systemImage: "chart.bar.fill")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
        }
        .accentColor(.blue)
    }
}

struct DashboardView: View {
    @State private var showExam = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Welcome Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome Back, Candidate")
                            .font(.title2.bold())
                        Text("Ready for your next challenge?")
                            .foregroundColor(.secondary)
                    }
                    .padding(.top)
                    
                    // Featured Test Card
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Engineering Mock Test #104")
                                    .font(.headline)
                                Text("60 Minutes • 30 Questions")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Image(systemName: "pencil.and.outline")
                                .font(.title)
                                .foregroundColor(.blue)
                        }
                        
                        Button(action: { showExam = true }) {
                            Text("Start Mock Test")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(14)
                                .shadow(color: Color.blue.opacity(0.3), radius: 10, y: 5)
                        }
                    }
                    .padding(24)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(24)
                    
                    // Previous Stats
                    HStack(spacing: 16) {
                        StatCard(title: "Avg Score", value: "78%", icon: "chart.line.uptrend.xyaxis", color: .green)
                        StatCard(title: "Rank", value: "#42", icon: "crown.fill", color: .orange)
                    }
                }
                .padding()
            }
            .navigationTitle("Dashboard")
            .fullScreenCover(isPresented: $showExam) {
                ExamView(viewModel: ExamViewModel(questions: MockData.sampleQuestions, duration: 3600))
            }
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title3)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.title2.bold())
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(20)
    }
}

struct ReportsOverviewView: View {
    var body: some View {
        NavigationView {
            Text("Detailed performance analysis will appear here.")
                .foregroundColor(.secondary)
                .navigationTitle("Reports")
        }
    }
}

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Account")) {
                    Text("Profile Settings")
                    Text("Subscription")
                }
                Section(header: Text("App")) {
                    Text("Notifications")
                    Text("Dark Mode")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

// Mock Data
struct MockData {
    static let sampleQuestions = [
        Question(text: "What is the primary function of a transistor in a circuit?", options: ["Amplification", "Rectification", "Filtration", "Insulation"], correctAnswerIndex: 0),
        Question(text: "Which of the following is a non-renewable source of energy?", options: ["Solar", "Wind", "Natural Gas", "Hydroelectric"], correctAnswerIndex: 2),
        Question(text: "In computer science, what does 'FIFO' stand for?", options: ["Fast In Fast Out", "First In First Out", "First In Final Out", "Fast In Final Out"], correctAnswerIndex: 1),
        Question(text: "What is the SI unit of electric current?", options: ["Volt", "Ohm", "Ampere", "Watt"], correctAnswerIndex: 2),
        Question(text: "Which protocol is used for sending emails?", options: ["HTTP", "FTP", "SMTP", "SNMP"], correctAnswerIndex: 2)
    ]
}
