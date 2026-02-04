import SwiftUI

struct CreativeFont: Identifiable {
    let id = UUID()
    let name: String
    let fontName: String
}

extension CreativeFont {
    static let all: [CreativeFont] = [
        CreativeFont(name: "Pacifico", fontName: "Pacifico-Regular"),
        CreativeFont(name: "Lobster", fontName: "Lobster-Regular"),
        CreativeFont(name: "Amatic SC", fontName: "AmaticSC-Regular"),
        CreativeFont(name: "Indie Flower", fontName: "IndieFlower-Regular"),
        CreativeFont(name: "Playfair", fontName: "PlayfairDisplay")
    ]
}