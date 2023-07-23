import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AuthenticationViewModel: ObservableObject {

    let db = Firestore.firestore()

    func register(userEmail: String, userPassword: String) {
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
            guard let user = authResult?.user else { return }
            let userData = ["email": user.email, "uid": user.uid]

            self.db.collection("users").document(user.uid).setData(userData) { error in
                if let error = error {
                    // Handle error
                    print("Error writing document: \(error)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
    
//    func login() {
//        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { authResult, error in
//            // Handle login result
//        }
//    }
}

