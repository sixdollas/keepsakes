import SwiftUI
struct Sticker: Identifiable {
    let id = UUID()
    var emoji: String
    var position: CGPoint
}