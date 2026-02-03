import SwiftUI

class PageStore: ObservableObject {
    @Published var pages: [ScrapbookPage] = []
    @Published var showTornEdgeOnNextPage: Bool = false
    
    private let saveURL: URL = {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docs.appendingPathComponent("scrapbook_pages.json")
    }()

    init() {
        load()
    }

    func save() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        if let data = try? encoder.encode(pages) {
            try? data.write(to: saveURL)
        }
    }

    func load() {
        if let data = try? Data(contentsOf: saveURL),
              let decodedPages = try? JSONDecoder().decode([ScrapbookPage].self, from: data) {
                pages = decoded
        }
    }
|}