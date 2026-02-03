import SwiftUI

struct NotebookTheme: Identifiable {
    let id = UUID()
    let name: String
    let background: AnyView
}

extension NotebookTheme {
    static let kraft = NotebookTheme(
        name: "Kraft Paper",
        background: AnyView(
            Color("KraftPaper")
                .ignoresSafeArea()
        )
    )

    static let grid = NotebookTheme(
        name: "Grid Paper",
        background: AnyView(
            GridPaperBackground()
        )
    )

    static let pastel = NotebookTheme(
        name: "Pastel",
        background: AnyView(
            LinearGradient(
                colors: [.pink.opacity(0.2), .blue.opacity(0.2)],                startPoint: .top,
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    )

    static let vintage = NotebookTheme(
        name: "Vintage",
        background: AnyView(
            Color("VintagePaper")
                .ignoresSafeArea(
        )
    )

    static let all: [NotebookTheme] = [.kraft, .grid, .dot, .pastel, .vintage]
}