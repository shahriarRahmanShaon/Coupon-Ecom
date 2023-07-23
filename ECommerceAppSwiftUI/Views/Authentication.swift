

import SwiftUI


struct UserModel: Identifiable {
    var id = UUID()
    var email: String
    var password: String
    var role: String
}

class UserViewModel: ObservableObject {
    @Published var currentUser: UserModel? = nil
}

//struct Authentication: View {
//    @ObservedObject var userViewModel: UserViewModel
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var role: String = "user"
//    
//    var body: some View {
//        Form {
//            TextField("Email", text: $email)
//            SecureField("Password", text: $password)
//            Picker("Role", selection: $role) {
//                Text("User").tag("user")
//                Text("Vendor").tag("vendor")
//            }
//            Button(action: {
//                // Assuming this signs up/logs in the user and updates the user in your view model
//                let newUser = UserModel(email: email, password: password, role: role)
//                userViewModel.currentUser = newUser
//            }) {
//                Text("Sign Up/Login")
//            }
//        }
//    }
//}


struct AuthenticationView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @State var email: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @State private var role: String = "user"
    
    var isSignInButtonDisabled: Bool {
        [email, password].contains(where: \.isEmpty)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Spacer()
            
            TextField("Email",
                      text: $email ,
                      prompt: Text("Email").foregroundColor(.blue)
            )
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.blue, lineWidth: 2)
            }
            .padding(.horizontal)
            HStack {
                Group {
                    if showPassword {
                        TextField("Password", // how to create a secure text field
                                    text: $password,
                                    prompt: Text("Password").foregroundColor(.red)) // How to change the color of the TextField Placeholder
                    } else {
                        SecureField("Password", // how to create a secure text field
                                    text: $password,
                                    prompt: Text("Password").foregroundColor(.red)) // How to change the color of the TextField Placeholder
                    }
                }
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.red, lineWidth: 2) // How to add rounded corner to a TextField and change it colour
                }

                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.red) // how to change image based in a State variable
                }

            }.padding(.horizontal)

            Picker("Role", selection: $role) {
                Text("User").tag("user")
                Text("Vendor").tag("vendor")
            }
            Spacer()

            Button {
                let newUser = UserModel(email: email, password: password, role: role)
                userViewModel.currentUser = newUser
            } label: {
                Text("Sign In")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity) // how to make a button fill all the space available horizontaly
            .background(
                isSignInButtonDisabled ? // how to add a gradient to a button in SwiftUI if the button is disabled
                LinearGradient(colors: [.gray], startPoint: .topLeading, endPoint: .bottomTrailing) :
                    LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(20)
            .disabled(isSignInButtonDisabled) // how to disable while some condition is applied
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
