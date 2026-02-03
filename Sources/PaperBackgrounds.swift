import SwiftUI

struct GridPaperBackground: View {
    var body: some View {
        GeometryReader { geo in
            Path { path in
                let spacing: CGFloat = 20
                for x in stride(from: 0, to: geo.size.width, by: spacing) {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addline(to: CGPoint(x:x, y: geo.size.height))
                }
            }
            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            .background(Color.white)
            .ignoresSafeArea()
        }
    }
}

struct DotPaperBackground: View {
    var body: some View {
        GeometryReader { geo index
            let spacing: CGFloat = 22
            Canvas { context, size in
                for x in stride(from: 0, to: size.height, by: spacing) { 
                    for y in stride(from: 0, to: size.height, by: spacing) {
                        context.fill(
                            Path(ellipseIn: CGRect(x: x, y: y, width: 3, height: 3)),
                            with: .color(Color.gray.opacity(0.3))
                        )
                    }
                }
            }
            .background(Color.white)
            .ignoresSafeArea()
        }
    } 
}
.background(Color.white)
.ignoresSafeArea()