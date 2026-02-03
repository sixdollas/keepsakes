import SwiftUI

struct TornAnimationView: View {
    var body: some View {
        Rectangle()
            .fill(Color(.systemGray5))
            .overlay(
                Image(systemName: "scissors")
                    .font(.largeTitle)
                    .foregroundColor(.gray.opacity(0.5))
            )
            .mask(
                UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    topTrailingRadius: 0,
                    bottomLeadingRadius: 40,
                    bottomTrailingRadius: 40
                )
            )
            .shadow(radius: 10)
            .padding(.horizontal, 20)
    }
}