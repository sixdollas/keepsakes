import SwiftUI

struct TornEdgeView: View {
    var body: some View {
        Rectangle()
            .fill(Color(.systemGray5))
            .overlay(
                Image(systemName: "scribble.variable")
                    .font(.largeTitle)
                    .foregroundColor(.gray.opacity(0.4))
            )
            .mask(
                UnevenroundedRectangle(
                    topLeadingRadius: 0,
                    topTrailingRadius: 0,
                    bottomLeadingRadius: 20,
                    bottomTrailingRadius: 20,
                    style: .continuous
                )
            )
    }
}