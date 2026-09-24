import Foundation

struct Transaction: Identifiable {
    let id = UUID()
    let title: String
    let amount: Double
    let date: Date
}

class UserProfile: ObservableObject {
    @Published var name: String

    init(name: String) {
        self.name = name
    }
}

class WalletViewModel: ObservableObject {
    @Published var balance = 500.0
    @Published var transactions = [
        Transaction(title: "საწყისი ბალანსი", amount: 500, date: Date())
    ]

    func topUp() {
        balance += 100
        transactions.insert(
            Transaction(title: "ბალანსის შევსება", amount: 100, date: Date()),
            at: 0
        )
    }
}
