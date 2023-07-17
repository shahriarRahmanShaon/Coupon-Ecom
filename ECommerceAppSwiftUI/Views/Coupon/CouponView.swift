import SwiftUI
struct CouponView: View {
    @State private var selectedDate = Date()
    @State private var validityDays = 7
    @State private var price = 10.0
    
    var body: some View {
        VStack {
            Text("Create a Coupon")
                .font(.title)
                .padding()
            
            DatePicker("Validity Date", selection: $selectedDate, displayedComponents: .date)
                .padding()
            
            Stepper("Validity Days: \(validityDays)", value: $validityDays, in: 1...30)
                .padding()
            
            Stepper("Price: $\(price, specifier: "%.2f")", value: $price, in: 0.0...100.0, step: 0.5)
                .padding()
            
            Text("Total Savings: $\(calculateSavings(), specifier: "%.2f")")
                .font(.headline)
                .padding()
            
            Spacer()
            
        }
    }
    
    func calculateSavings() -> Double {
        let savingsPerDay = 5.0 // Customize the savings rate per day
        let totalSavings = savingsPerDay * Double(validityDays)
        return totalSavings
    }
}



