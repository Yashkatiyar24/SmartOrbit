# 🚀 SmartOrbit

> Your personal exam preparation companion – practice like you're in the real exam hall!

Hey there! 👋 Welcome to **SmartOrbit**, an iOS app I built to help students ace their placement tests and competitive exams. Whether you're preparing for Google, Amazon, TCS, or any other company's hiring process, this app gives you that real exam-day feel.

## 📱 What's This All About?

I noticed that most practice apps don't really simulate the pressure of a real exam. You know that feeling when the timer is ticking down and you need to decide whether to attempt a question or skip it? That's exactly what SmartOrbit recreates.

**Built with SwiftUI** • **Clean MVVM Architecture** • **iOS 15+**

---

## ✨ Features

### 🔐 Authentication
- Sign in with Email/Password
- Apple Sign-In integration
- Google Sign-In support
- Clean, modern login UI

### 📝 Exam Mode
- **Full-screen distraction-free environment** – no notifications, no distractions
- **Smart countdown timer** that changes color as time runs out:
  - 🔵 Blue = Plenty of time
  - 🟠 Orange = Better hurry up!
  - 🔴 Red = Last few minutes!
- **Question palette** for quick navigation between questions
- **Mark for review** – flag questions you want to revisit
- Track your progress with color-coded question states (Unseen, Attempted, Marked)

### 🏢 Placement Tests
Practice for top companies including:
- Google (Software Engineer)
- Amazon (SDE-I)
- Microsoft (Software Engineer)
- Meta (Software Engineer)
- TCS (Digital Engineer)
- Infosys (Systems Engineer)

Each test comes with a difficulty rating so you know what you're getting into!

### 📊 Performance Reports
After each test, get a detailed breakdown of:
- Questions attempted vs skipped
- Marked for review count
- Time taken per question
- Overall performance summary

---

## 🏗️ Project Structure

```
SmartOrbit/
├── App/
│   └── SmartorbitApp.swift      # App entry point
├── Models/
│   └── Question.swift            # Question data model
├── ViewModels/
│   ├── AuthViewModel.swift       # Authentication logic
│   ├── ExamViewModel.swift       # Exam state management
│   └── TimerViewModel.swift      # Timer logic
└── Views/
    ├── LoginView.swift           # Login & Sign up screens
    ├── MainViews.swift           # Tab bar & navigation
    ├── PlacementTestsView.swift  # Company selection
    ├── ExamView.swift            # Main exam interface
    ├── ExamComponents.swift      # Reusable exam UI components
    └── ReportView.swift          # Post-exam results
```

---

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0 or later
- iOS 15.0+ device or simulator
- macOS Sonoma or later (recommended)

### Installation

1. **Clone the repo**
   ```bash
   git clone https://github.com/Yashkatiyar24/SmartOrbit.git
   ```

2. **Open in Xcode**
   ```bash
   cd SmartOrbit
   open SmartOrbit.xcodeproj
   ```

3. **Build and Run**
   - Select your target device/simulator
   - Hit `Cmd + R` and you're good to go! 🎉

---

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| SwiftUI | Modern declarative UI |
| Combine | Reactive data binding |
| MVVM | Clean architecture pattern |
| Swift 5.10+ | Latest Swift features |

---

## 📸 Screenshots

*Coming soon!* 

---

## 🤝 Contributing

Found a bug? Have a feature idea? Feel free to:
1. Fork the repo
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is open source and available under the MIT License.

---

## 👨‍💻 Author

**Yash Katiyar**

- GitHub: [@Yashkatiyar24](https://github.com/Yashkatiyar24)

---

<p align="center">
  Made with ❤️ and lots of ☕
  <br>
  <i>Good luck with your placements! 🍀</i>
</p>
