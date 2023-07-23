import SwiftUI

enum chooseType{
    case camera
    case photoLibrary
}
struct AddContentView: View {
    @State private var clothName = ""
    @State private var description = ""
    @State private var imageURL = ""
    @State private var price = ""
    @State private var company = ""
    @State private var rating = 0
    @State private var type = ""
    @State private var isFavorite = false
    @State private var color = ""
    @State private var size = ""
    @State private var discount = 0
    @EnvironmentObject var viewModel: ClothViewModel
    @State private var clothAdded = true
    
    @State private var isShowingImagePicker = false
    @State private var isShowingCamera = false
    @State private var selectedImage: Image? = nil
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    var body: some View {
        Form {
            Section(header: Text("Cloth Details")) {
                TextField("Name", text: $clothName)
                TextField("Description", text: $description)
                Button(action: {
                    isShowingCamera = true
                }) {
                    Text("Upload Product Image")
                }
                TextField("Price", text: $price)
                    .keyboardType(.numberPad)
                TextField("Company", text: $company)
                Stepper("Rating: \(rating)", value: $rating, in: 1...5)
                TextField("Type", text: $type)
                Toggle("Favorite", isOn: $isFavorite)
            }
            
            Section(header: Text("Additional Details")) {
                TextField("Color", text: $color)
                TextField("Size", text: $size)
                Stepper("Discount: \(discount)%", value: $discount, in: 0...100)
            }
            
            Button(action: addCloth) {
                Text("Add Cloth")
            }
        }
        .navigationTitle("Add Cloth")
        .actionSheet(isPresented: $isShowingCamera) {
            ActionSheet(title: Text("How do you want to upload?"), buttons: [
                .default(Text("Camera"), action: {
                    sourceType = .camera
                    isShowingImagePicker = true
                }),
                .default(Text("Phone Gallery"), action: {
                    sourceType = .photoLibrary
                    isShowingImagePicker = true
                }),
                .cancel()
            ])
        }
        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $selectedImage, sourceType: $sourceType)
        }
    }
    
    private func loadImage() {
        
    }
    func addCloth() {
        
        let newCloth = Cloth(name: clothName, description: description, imageURL: selectedImage, price: Int(price) ?? 0, company: company, rating: rating, type: type, isFavorite: isFavorite, color: color, size: size, discount: discount)
        
        viewModel.addCloth(newCloth)
        clothName = ""
        description = ""
        imageURL = ""
        print(viewModel.cloths.count)
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: Image?
    @Binding var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = Image(uiImage: uiImage)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
