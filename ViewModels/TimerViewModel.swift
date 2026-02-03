import Foundation
import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    @Published var timeRemaining: TimeInterval
    @Published var isRunning: Bool = false
    
    private var timer: AnyCancellable?
    private var startTime: Date?
    private let initialTime: TimeInterval
    
    var onTimeUp: (() -> Void)?
    
    init(duration: TimeInterval) {
        self.timeRemaining = duration
        self.initialTime = duration
        setupNotifications()
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc private func didEnterBackground() {
        handleDidEnterBackground()
    }
    
    @objc private func willEnterForeground() {
        handleWillEnterForeground()
    }
    
    func start() {
        isRunning = true
        startTime = Date()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }
    
    func pause() {
        isRunning = false
        timer?.cancel()
    }
    
    private func tick() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            stop()
            onTimeUp?()
        }
    }
    
    func stop() {
        isRunning = false
        timer?.cancel()
    }
    
    var timeString: String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var timerColor: Color {
        if timeRemaining > 300 { // 5 minutes
            return Color.blue
        } else if timeRemaining > 60 { // 1 minute
            return Color.orange
        } else {
            return Color.red
        }
    }
    
    // Handle app backgrounding/foregrounding
    func handleDidEnterBackground() {
        startTime = Date()
    }
    
    func handleWillEnterForeground() {
        guard isRunning, let startTime = startTime else { return }
        let elapsed = Date().timeIntervalSince(startTime)
        timeRemaining = max(0, timeRemaining - elapsed)
        if timeRemaining == 0 {
            stop()
            onTimeUp?()
        }
    }
}
