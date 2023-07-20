import SwiftUI

struct TabBarView: View {
    
    @State var selected = 0
    var userMode: UserModel
    
    var body: some View {
        ZStack {
            Color.init(hex: "f9f9f9")
                .edgesIgnoringSafeArea(.all)
            TabView(selection: $selected) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }.tag(0)
                Shopping()
                    .tabItem {
                        Image(systemName: "cart.fill")
                        Text("Shop")
                    }.tag(1)
                CouponView(user: userMode)
                    .tabItem {
                        Image(systemName: "tag.square.fill")
                        Text("Coupon")
                    }.tag(2)
                BagView()
                    .tabItem {
                        Image(systemName: "bag.fill")
                        Text("Cart")
                    }.tag(3)
                ProfileView()
                    .tabItem {
                        Image(systemName: "ellipsis.circle.fill")
                        Text("More")
                    }.tag(4)
            }
        }
        .accentColor(Color.init(hex: "DB3022"))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

