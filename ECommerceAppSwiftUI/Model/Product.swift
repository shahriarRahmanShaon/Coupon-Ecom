import Foundation

struct Cloth: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let imageURL: Image?
    let price: Int
    let company: String
    let rating: Int
    let type: String
    let isFavorite: Bool
    let color: String
    let size: String
    let discount: Int
}

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Int
    let description: String
    let category: CategoryForProduct
    let images: [String]
}

struct CategoryForProduct: Codable {
    let id: Int
    let name: String
    let image: String
}



extension Cloth {
    
    static func all() -> [Cloth] {
        return [
            Cloth(name: "Printed Long Top", description: "Red floral print long top, has a round collar, full sleeves and available in different sizes for women.", imageURL: Image("kidsDress"), price: 2399, company: "Rain & Rainbow", rating: 4, type: "sale", isFavorite: false, color: "Red", size: "S", discount: 40),
            Cloth(name: "Men Pullover Sweater", description: "Green ribbed pullover sweater, has a round neck, long sleeves, straight hem.", imageURL: Image("tshirts"), price: 3449, company: "Mark & Spencer", rating: 5, type: "sale", isFavorite: true, color: "Green", size: "M", discount: 30),
            Cloth(name: "Black Fit Top", description: "Black coloured self design woven fit and flare top has round neck and half sleeves.", imageURL: Image("overcoat"), price: 2799, company: "Kook N Keen Garfield", rating: 3, type: "sale", isFavorite: false, color: "Black", size: "L", discount: 45),
            Cloth(name: "Longline Over Coat", description: "Gray longline over coat, has a notched lapel collar, button closure, long sleeves.", imageURL: Image("blackTop"), price: 5149, company: "Chemistry Edition", rating: 4, type: "sale", isFavorite: true, color: "Gray", size: "L", discount: 30),
            Cloth(name: "Women Printed Flare Dress", description: "Green printed woven fit and flare dress, has a notched lapel collar and sleevesless.", imageURL: Image("blackTop"), price: 2149, company: "Chemistry Edition", rating: 4, type: "new", isFavorite: false, color: "Green", size: "L", discount: 40),
        ]
    }
}


import SwiftUI

class ClothViewModel: ObservableObject {
    @Published var cloths: [Cloth]

    init() {
        cloths = Cloth.all()
    }

    func addCloth(_ cloth: Cloth) {
        cloths.append(cloth)
    }
}
