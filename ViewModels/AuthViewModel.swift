import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var isLoading: Bool = false
    @Published var showPassword: Bool = false
    @Published var errorMessage: String?
    
    // Validation
    var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    var isPasswordValid: Bool {
        return password.count >= 6
    }
    
    var canSignIn: Bool {
        return isEmailValid && isPasswordValid
    }
    
    // MARK: - Sign In
    func signIn() {
        guard canSignIn else {
            errorMessage = "Please enter valid email and password"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        // Simulate network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.isLoading = false
            self?.isAuthenticated = true
        }
    }
    
    // MARK: - Sign In with Apple
    func signInWithApple() {
        isLoading = true
        errorMessage = nil
        
        // Simulate Apple Sign In
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.isLoading = false
            self?.isAuthenticated = true
        }
    }
    
    // MARK: - Sign In with Google
    func signInWithGoogle() {
        isLoading = true
        errorMessage = nil
        
        // Simulate Google Sign In
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.isLoading = false
            self?.isAuthenticated = true
        }
    }
    
    // MARK: - Sign Out
    func signOut() {
        isAuthenticated = false
        email = ""
        password = ""
    }
    
    // MARK: - Forgot Password
    func forgotPassword() {
        guard isEmailValid else {
            errorMessage = "Please enter a valid email address"
            return
        }
        // Handle forgot password logic
        errorMessage = "Password reset link sent to \(email)"
    }
}
