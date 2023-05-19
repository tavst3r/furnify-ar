import SwiftUI

struct SplashView: View {
    @State private var isLogoFilled = false
    
    var body: some View {
        ZStack {
            Color.blue // Replace with your desired background color
            
            Image(isLogoFilled ? "logo-splash-fill" : "logo-splash-outline")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 200)
                .foregroundColor(.white)
                .animation(.easeInOut(duration: 1.0)) // Adjust animation duration as needed
        }
        .onAppear {
            isLogoFilled = true // Transition the logo to filled on appear
        }
        .edgesIgnoringSafeArea(.all)
    }
}

