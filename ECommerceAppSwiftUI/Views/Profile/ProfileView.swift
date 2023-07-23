import SwiftUI
import Combine

struct ProfileView: View {
    
    @State var selection: Int? = nil
    let arrProfile = ProfileModel.all()
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    fileprivate func NavigationBarView() -> some View {
        return HStack {
            Text("")
        }
        .frame(width: UIScreen.main.bounds.width, height: 45)
        .overlay(
            Text("More")
                .font(.custom(Constants.AppFont.semiBoldFont, size: 15))
                .padding(.horizontal, 10)
            , alignment: .center)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                NavigationBarView()
                HStack {
                    Image("banner4")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(.leading, 15)
                    VStack(alignment: .leading) {
                        Text(userViewModel.currentUser?.name ?? "")
                            .font(.headline)
                            .bold()
                        Text(userViewModel.currentUser?.email ?? "")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }.padding(.horizontal, 5)
                    Spacer()
                }.padding(.vertical, 10)
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(spacing: 10) {
                        ForEach(self.arrProfile, id: \.id) { profile in
                            ProfileRow(profile: profile)
                        }
                        Button {
                            withAnimation {
                                userViewModel.currentUser = nil
                                presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            Text("Log Out")
                                .foregroundColor(.red)
                                .padding(.top, 35)
                                
                        }
                    }
                    .padding(.horizontal, 15)
                })
               

                
                Spacer()
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct ProfileRow: View {
    
    let profile: ProfileModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(5)
                .shadow(color: Constants.AppColor.shadowColor, radius: 1, x: 0.8, y: 0.8)
            VStack(alignment: .leading) {
                Text(profile.title)
                    .font(.subheadline)
                    .bold()
                    .padding(.bottom, 1)
                Text(profile.subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(15)
            Spacer()
        }
    }
}
