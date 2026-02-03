import SwiftUI
import PencilKit

struct ScrapbookPage: Identifiable, codable {
    let id: UUIDvar date: Datevar journalText: String
     var date: Date
     var journalText: String
    var photos: [PhotoItemCodable]
    var stickers: [StickerCodable]
    var drawingData: Data? //PencilKit drawing saved as PNG
}

// MARK: - Codable wrappers for non-Codable types

struct PhotoItemCodable: Codable {
    var imageData: Data
    var positionX: CGFloat
    var positionY: CGFloat
    var scale: CGFloat
    var offsetWidth: CGFloat
    var offsetHeight: CGFloat
    var rotationDegrees: Double
    var zIndex: Double
}

struct StickerCodable: Codable {
    var id: UUID
    var emoji: String
    var positionX: CGFloat
    var positionY: CGFloat
}