import SwiftUI

struct LoginView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var showSignUp = false
    
    var body: some View {
        if authViewModel.isAuthenticated {
            MainTabView()
        } else {
            loginContent
        }
    }
    
    var loginContent: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer().frame(height: 40)
                
                // App Logo
                appLogo
                
                // Welcome Text
                welcomeText
                
                // Social Sign In Buttons
                socialSignInButtons
                
                // Divider
                dividerView
                
                // Email & Password Fields
                inputFields
                
                // Forgot Password
                forgotPasswordButton
                
                // Sign In Button
                signInButton
                
                Spacer().frame(height: 20)
                
                // Sign Up Link
                signUpLink
                
                Spacer().frame(height: 40)
            }
            .padding(.horizontal, 24)
        }
        .background(Color(UIColor.systemBackground))
        .overlay(loadingOverlay)
    }
    
    // MARK: - App Logo
    var appLogo: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [Color(hex: "4A90FF"), Color(hex: "6366F1")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 80, height: 80)
            
            Image(systemName: "bolt.fill")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.white)
        }
        .shadow(color: Color(hex: "4A90FF").opacity(0.4), radius: 20, y: 10)
    }
    
    // MARK: - Welcome Text
    var welcomeText: some View {
        VStack(spacing: 8) {
            Text("Welcome Back")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.primary)
            
            Text("Sign in to continue to your account")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    // MARK: - Social Sign In Buttons
    var socialSignInButtons: some View {
        VStack(spacing: 12) {
            // Apple Sign In
            Button(action: { authViewModel.signInWithApple() }) {
                HStack(spacing: 12) {
                    Image(systemName: "apple.logo")
                        .font(.system(size: 20, weight: .semibold))
                    Text("Continue with Apple")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.black)
                .cornerRadius(16)
            }
            
            // Google Sign In
            Button(action: { authViewModel.signInWithGoogle() }) {
                HStack(spacing: 12) {
                    // Google "G" logo
                    Text("G")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.red)
                    Text("Continue with Google")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color(UIColor.secondarySystemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(UIColor.separator), lineWidth: 1)
                )
                .cornerRadius(16)
            }
        }
    }
    
    // MARK: - Divider
    var dividerView: some View {
        HStack {
            Rectangle()
                .fill(Color(UIColor.separator))
                .frame(height: 1)
            
            Text("or")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.horizontal, 16)
            
            Rectangle()
                .fill(Color(UIColor.separator))
                .frame(height: 1)
        }
    }
    
    // MARK: - Input Fields
    var inputFields: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Email Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                HStack(spacing: 12) {
                    Image(systemName: "envelope")
                        .foregroundColor(.secondary)
                        .frame(width: 20)
                    
                    TextField("Enter your email", text: $authViewModel.email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(UIColor.separator), lineWidth: 1)
                )
            }
            
            // Password Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Password")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                HStack(spacing: 12) {
                    Image(systemName: "lock")
                        .foregroundColor(.secondary)
                        .frame(width: 20)
                    
                    if authViewModel.showPassword {
                        TextField("Enter your password", text: $authViewModel.password)
                            .textContentType(.password)
                    } else {
                        SecureField("Enter your password", text: $authViewModel.password)
                            .textContentType(.password)
                    }
                    
                    Button(action: { authViewModel.showPassword.toggle() }) {
                        Image(systemName: authViewModel.showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(UIColor.separator), lineWidth: 1)
                )
            }
            
            // Error Message
            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.top, 4)
            }
        }
    }
    
    // MARK: - Forgot Password Button
    var forgotPasswordButton: some View {
        HStack {
            Spacer()
            Button(action: { authViewModel.forgotPassword() }) {
                Text("Forgot Password?")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hex: "4A90FF"))
            }
        }
    }
    
    // MARK: - Sign In Button
    var signInButton: some View {
        Button(action: { authViewModel.signIn() }) {
            Text("Sign In")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    LinearGradient(
                        colors: [Color(hex: "4A90FF"), Color(hex: "6366F1")],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(16)
                .shadow(color: Color(hex: "4A90FF").opacity(0.4), radius: 15, y: 8)
        }
    }
    
    // MARK: - Sign Up Link
    var signUpLink: some View {
        HStack(spacing: 4) {
            Text("Don't have an account?")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button(action: { showSignUp = true }) {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hex: "4A90FF"))
            }
        }
    }
    
    // MARK: - Loading Overlay
    @ViewBuilder
    var loadingOverlay: some View {
        if authViewModel.isLoading {
            ZStack {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.white)
                    
                    Text("Signing in...")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding(32)
                .background(Color(UIColor.systemGray5).opacity(0.9))
                .cornerRadius(16)
            }
        }
    }
}

// MARK: - Color Extension for Hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
