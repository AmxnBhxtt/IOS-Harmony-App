import SwiftUI

struct AppSelectionView: View {
    let allApps = ["Camera", "Messages", "Calendar", "Apple Music", "Health",
                   "Phone", "Maps", "Photos", "Settings", "Safari", "Mail"]
    
    @State private var selectedApps = Set<String>()
    @State private var navigateToContentView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Select Apps")
                    .font(.largeTitle)
                    .padding()
                
                List(allApps, id: \.self, selection: $selectedApps) { app in
                    Text(app)
                }
                .environment(\.editMode, .constant(.active)) // Enable multiple selection
                
                Button(action: {
                    navigateToContentView = true
                }) {
                    Text("Continue")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(selectedApps.isEmpty) // Disable button if no apps are selected
                
                NavigationLink(destination: ContentView(selectedApps: Array(selectedApps)), isActive: $navigateToContentView) {
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .navigationBarTitle("App Selection", displayMode: .inline)
        }
    }
}

struct AppSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AppSelectionView()
    }
}
