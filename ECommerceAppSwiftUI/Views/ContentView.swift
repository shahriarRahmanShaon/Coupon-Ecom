import SwiftUI

struct ContentView: View {
    @StateObject private var userViewModel = UserViewModel()
    
    var body: some View {
        if let user = userViewModel.currentUser {
            TabBarView(userMode: user)
        } else {
            Authentication(userViewModel: userViewModel)
        }
    }
}


