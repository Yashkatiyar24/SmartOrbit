# SmartOrbit

SmartOrbit is a high-performance, real exam-style iOS application built using Swift and SwiftUI. It is designed to mimic professional testing platforms like JEE, GATE, and UPSC.

## Features

- **Full-Screen Exam Mode**: A distraction-free environment for test-taking.
- **Smart Countdown Timer**: Real-time timer with visual urgency colors (Blue, Orange, Red) and background persistence.
- **Question Palette**: Instant navigation between questions with status color-coding.
- **MCQ Question System**: Support for multiple-choice questions with states including Unseen, Attempted, and Marked for Review.
- **Performance Reports**: Detailed post-exam summary of attempts and review status.
- **MVVM Architecture**: Clean, scalable code with separate logic for timers and exam management.

## Tech Stack

- **UI Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Language**: Swift 5.10+
- **Platform**: iOS 15.0+

## Project Structure

- `App/`: Entry point and main app configuration.
- `Models/`: Data structures (e.g., `Question`).
- `ViewModels/`: Business logic for the exam and timer.
- `Views/`: SwiftUI views and components.

## Getting Started

1. Open the project folder in Xcode (or copy the files into a new SwiftUI project).
2. Set the build target to an iOS device or simulator.
3. Build and run (Cmd + R).

---
Created with ❤️ by Antigravity
