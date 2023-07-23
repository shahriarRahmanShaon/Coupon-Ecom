import SwiftUI

struct TabBarView: View {
    
    @State var selected = 0
    var userMode: UserModel
    @EnvironmentObject var viewModel: ClothViewModel
    
    var body: some View {
        ZStack {
            Color.init(hex: "f9f9f9")
                .edgesIgnoringSafeArea(.all)
            TabView(selection: $selected) {
                if userMode.role == "user"{
                    HomeView().environmentObject(viewModel)
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }.tag(0)
                    Shopping().environmentObject(viewModel)
                        .tabItem {
                            Image(systemName: "cart.fill")
                            Text("Shop")
                        }.tag(1)
//                    CouponView(user: userMode).environmentObject(viewModel)
//                        .tabItem {
//                            Image(systemName: "tag.square.fill")
//                            Text("Coupon")
//                        }.tag(2)
                    BagView().environmentObject(viewModel)
                        .tabItem {
                            Image(systemName: "bag.fill")
                            Text("Cart")
                        }.tag(3)
                    ProfileView().environmentObject(viewModel)
                        .tabItem {
                            Image(systemName: "ellipsis.circle.fill")
                            Text("Profile")
                        }.tag(4)
                }else{
//                    CouponView(user: userMode).environmentObject(viewModel)
//                        .tabItem {
//                            Image(systemName: "tag.square.fill")
//                            Text("Add Coupon")
//                        }.tag(1)
                    AddContentView().environmentObject(viewModel)
                        .tabItem {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Product")
                        }.tag(2)
                    ProfileView().environmentObject(viewModel)
                        .tabItem {
                            Image(systemName: "ellipsis.circle.fill")
                            Text("Profile")
                        }.tag(4)
                }
            }
        }
        .accentColor(Color.init(hex: "DB3022"))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

