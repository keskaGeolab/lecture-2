import SwiftUI

@main
struct ShoppingListApp: App {
    @StateObject private var user = UserProfile(name: "ნინო")

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(user)
        }
    }
}
