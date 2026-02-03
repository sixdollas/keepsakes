import SwiftUI

struct NotebookSpineView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(.darkGray), Color(.black)],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(spacing: 8) {
                ForEach(0..<12) { _ in
                    Capsule()
                        .fill(Color(.lightGray))
                        .frame(width: 8, height: 20)
                }
            }
        }
    }
}