import SwiftUI

@main
struct KeepsakesApp: App {
    @StateObject var pageStore = PageStore()

    var body: some Scene {
        WindowGroup {
            PageListView()
                .environmentObject(pageStore)
        }
    }
}