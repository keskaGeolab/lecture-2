import SwiftUI

struct ContentView: View {
    @State private var isBalanceHidden = false
    @State private var isDarkMode = false
    @StateObject private var wallet = WalletViewModel()

    var body: some View {
        ZStack {
            (isDarkMode ? Color.black : Color(.systemGroupedBackground))
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    GreetingView()

                    CardContainer {
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                Text("ბალანსი")
                                    .font(.headline)

                                Spacer()

                                BalanceToggleButton(isHidden: $isBalanceHidden)
                            }

                            if isBalanceHidden {
                                Text("••••••")
                                    .font(.system(size: 36, weight: .bold))
                            } else {
                                Text("₾ \(wallet.balance, specifier: "%.2f")")
                                    .font(.system(size: 36, weight: .bold))
                            }

                            Button("შევსება +₾100") {
                                wallet.topUp()
                            }
                            .frame(maxWidth: .infinity)
                            .buttonStyle(.borderedProminent)
                        }
                    }

                    CardContainer {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("ტრანზაქციები")
                                .font(.headline)

                            ForEach(wallet.transactions) { transaction in
                                TransactionRow(transaction: transaction)
                            }
                        }
                    }

                    Toggle("🌙 ღამის რეჟიმი", isOn: $isDarkMode)
                        .padding(.horizontal, 5)
                }
                .padding()
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct GreetingView: View {
    @EnvironmentObject var user: UserProfile

    var body: some View {
        Text("გამარჯობა, \(user.name)!")
            .font(.largeTitle.bold())
    }
}

struct BalanceToggleButton: View {
    @Binding var isHidden: Bool

    var body: some View {
        Button {
            isHidden.toggle()
        } label: {
            Image(systemName: isHidden ? "eye.slash" : "eye")
        }
    }
}

struct CardContainer<Content: View>: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(18)
            .shadow(radius: 5)
    }
}

struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack {
            Image(systemName: "arrow.down.circle.fill")
                .foregroundStyle(.green)

            VStack(alignment: .leading) {
                Text(transaction.title)
                Text(transaction.date, style: .date)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }

            Spacer()

            Text("+₾\(transaction.amount, specifier: "%.2f")")
                .foregroundStyle(.green)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UserProfile(name: "ნინო"))
}

#Preview("Balance Button") {
    BalanceTogglePreview()
}

struct BalanceTogglePreview: View {
    @State private var hidden = false

    var body: some View {
        BalanceToggleButton(isHidden: $hidden)
            .padding()
    }
}
