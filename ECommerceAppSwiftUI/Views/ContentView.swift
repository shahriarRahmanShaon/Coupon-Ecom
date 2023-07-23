import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        if let user = userViewModel.currentUser {
            TabBarView(userMode: user)
        } else {
            AuthenticationView().environmentObject(userViewModel)
        }
    }
}


