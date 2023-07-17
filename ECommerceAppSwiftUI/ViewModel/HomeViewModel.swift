import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var response: [Product] = []
    private var cancellable: AnyCancellable?
    
    func fetchDataForAllProducts(_ offset:Int, _ limit: Int) {
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/products?offset=\(offset)&limit=\(limit)") else {
            return
        }
        
        let request = URLRequest(url: url)
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [Product].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                self?.response = products
            }
    }
}
