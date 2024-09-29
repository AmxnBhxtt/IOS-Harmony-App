import SwiftUI
import LocalAuthentication

struct ExitConfirmationView: View {
    @Binding var isPresented: Bool
    @State private var showExitAlert = false
    var elapsedTime: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Are you sure you want to exit this app?")
                .font(.headline)
                .padding()
            
            Text("Time Used:")
                .font(.headline)
                .padding()
            
            Text(formatElapsedTime(elapsedTime))
                .font(.system(size: 50, weight: .bold, design: .monospaced))
            
            Button(action: {
                authenticateAndExit()
            }) {
                Text("Confirm Exit")
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .background(Color.white)
        .navigationBarTitle("Exit Confirmation", displayMode: .inline)
        .alert(isPresented: $showExitAlert) {
            Alert(
                title: Text("Exit App"),
                message: Text("Failed to authenticate"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func authenticateAndExit() {
        let context = LAContext()
        var error: NSError?
        
        // Check if the device can evaluate the policy
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Authenticate to exit the app"
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        exit(0)
                    } else {
                        // Authentication failed
                        showExitAlert = true
                        print("Authentication failed: \(String(describing: authenticationError?.localizedDescription))")
                    }
                }
            }
        } else {
            // Device does not support authentication
            showExitAlert = true
            print("Authentication not available: \(String(describing: error?.localizedDescription))")
        }
    }
    
    func formatElapsedTime(_ seconds: Int) -> String {
        let hrs = seconds / 3600
        let mins = (seconds % 3600) / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d:%02d", hrs, mins, secs)
    }
}

struct ExitConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ExitConfirmationView(isPresented: .constant(true), elapsedTime: 0)
    }
}
