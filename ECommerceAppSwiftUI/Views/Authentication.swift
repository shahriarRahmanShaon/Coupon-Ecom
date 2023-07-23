

import SwiftUI


struct UserModel: Identifiable {
    var id = UUID()
    var email: String
    var password: String
    var role: String
    var name: String
    var shippingAddress: String
    var companyName: String?
}

class UserViewModel: ObservableObject {
    @Published var currentUser: UserModel? = nil
}


struct AuthenticationView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var role: String = "user"
    @State private var name: String = ""
    @State private var shippingAddress: String = ""
    @State private var isLoading: Bool = false
    @State private var companyName: String = ""
    
    var isSignInButtonDisabled: Bool {
        [email, password, name, shippingAddress].contains(where: \.isEmpty) || !isValidEmail(email)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Image("c").resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            
            TextField("Email",
                      text: $email,
                      prompt: Text("Email")
            )
            .textContentType(.emailAddress) // Set the keyboard type to email address
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.blue, lineWidth: 2)
            }
            .padding(.horizontal)
            
            if !isValidEmail(email) && !email.isEmpty {
                Text("Please enter a valid email address")
                    .foregroundColor(.red)
                    .padding(.horizontal)
            }
            
            Group{
                TextField("Name", text: $name)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 2)
                    }
                    .padding(.horizontal)
                
                TextField("Shipping Address", text: $shippingAddress)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 2)
                    }
                    .padding(.horizontal)
            }
            
            HStack {
                Group {
                    if showPassword {
                        TextField("Password", text: $password, prompt: Text("Password").foregroundColor(.red))
                    } else {
                        SecureField("Password", text: $password, prompt: Text("Password").foregroundColor(.red))
                    }
                }
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.red, lineWidth: 2)
                }
                
                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.red)
                }
            }.padding(.horizontal)
            
            HStack{
                Text("Login as: ")
                Spacer()
                Picker("Role", selection: $role) {
                    Text("User").tag("user")
                    Text("Vendor").tag("vendor")
                }
            }.padding()
            if role == "vendor" {
                            TextField("Your Company Name", text: $companyName)
                                .padding(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.blue, lineWidth: 2)
                                }
                                .padding(.horizontal)
                        }
            Spacer()
            
            Button {
                isLoading = true // Show loader when the button is tapped
                let newUser = UserModel(email: email, password: password, role: role, name: name, shippingAddress: shippingAddress, companyName: companyName)
                // Simulate a delay to simulate the sign-in process
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    isLoading = false // Hide loader after the sign-in process is complete
                    userViewModel.currentUser = newUser
                }
            } label: {
                if isLoading {
                    ProgressView() // Built-in loader (activity indicator)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(20)
                } else {
                    Text("Sign In")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(20)
                }
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(
                isSignInButtonDisabled ?
                LinearGradient(colors: [.gray], startPoint: .topLeading, endPoint: .bottomTrailing) :
                    LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(20)
            .disabled(isSignInButtonDisabled)
            .padding()
        }
        .background(Color("c-com"))
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
