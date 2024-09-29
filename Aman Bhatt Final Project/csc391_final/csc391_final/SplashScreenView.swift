import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false

    var body: some View {
        VStack {
            if isActive {
                AppSelectionView()
            } else {
                VStack {
                    Image("icon") // Use the image from the assets
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text("HARMONY APP")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
