import SwiftUI

struct ContentView: View {
    let icons = ["camera.fill", "message.fill", "calendar", "music.note", "heart.fill",
                 "phone.fill", "map.fill", "photo.fill", "gearshape.fill", "safari.fill", "envelope.fill"]
    
    let labels = ["Camera", "Messages", "Calendar", "Apple Music", "Health",
                  "Phone", "Maps", "Photos", "Settings", "Safari", "Mail"]
    
    let urls = [
        "photos://",            // Camera
        "sms://",               // Messages
        "calshow://",           // Calendar
        "music://",             // Apple Music
        "x-apple-health://",    // Health
        "tel://",               // Phone
        "maps://",              // Maps
        "photos://",            // Photos
        "App-Prefs://",         // Settings
        "http://",              // Safari
        "mailto:"               // Mail
    ]
    
    var selectedApps: [String]
    @State private var showingExitConfirmation = false
    @State private var elapsedTime = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(selectedApps: [String]) {
        self.selectedApps = selectedApps
        _timer = State(initialValue: Timer.publish(every: 1, on: .main, in: .common).autoconnect())
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                        ForEach(0..<selectedApps.count, id: \.self) { index in
                            let appIndex = labels.firstIndex(of: selectedApps[index]) ?? 0
                            Button(action: {
                                openAppWithURL(urlString: urls[appIndex])
                            }) {
                                VStack {
                                    Image(systemName: icons[appIndex])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                    Text(selectedApps[index])
                                        .fontWeight(.bold)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                }
                Button(action: {
                    showingExitConfirmation = true
                }) {
                    Text("Exit")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .background(Color.white)
            .navigationBarTitle("Main Menu", displayMode: .inline)
            .navigationBarBackButtonHidden(true) // Hide back button
            .navigationBarHidden(true) // Hide navigation bar
            .sheet(isPresented: $showingExitConfirmation) {
                ExitConfirmationView(isPresented: $showingExitConfirmation, elapsedTime: elapsedTime)
            }
            // Increment the elapsed time every second
            .onReceive(timer) { _ in
                elapsedTime += 1
            }
        }
    }
    
    func openAppWithURL(urlString: String) {
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Cannot open URL: \(urlString)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedApps: ["Camera", "Messages", "Calendar"])
    }
}
