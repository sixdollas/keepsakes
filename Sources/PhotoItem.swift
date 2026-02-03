import SwiftUI

struct PhotoItem: Identifiable {
    let id = UUID()
    var image: UIImage
    var position: CGPoint
    var scale: CGFloat = 1.0
    var offset: CGSize = .zero   // for cropping movement
    var rotation: Angle = .zero
    var zIndex: Double = 0
}