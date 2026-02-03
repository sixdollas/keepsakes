import SwiftUI
import PencilKit

struct LoadedPageView: View {
    @State private var showPage = false

    ScrollView {
        VStack(alignment: .leading, spacing: 20) {

        let page: ScrapbookPage

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    Text(page.date.formatted(date: .long, time: .omitted))
                        .font(.title)
                        .bold()

                    // Journal
                    if !page.journalText.isEmpty {
                        Text(page.journalText)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                        }

                    // Photos
                        ForEach(page.photos, id: \.id) { photo in
                            if let uiImage = UIImage(data: photo.imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(12)
                            }
                        }

                        // Stickers
                        if !page.stickers.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Stickers")
                                    .font(.headline)

                                ForEach(page.stickers, id: \.id) { sticker in
                                    Text(sticker.emoji)
                                        .font(.largeTitle)
                                }
                            }
                        }

                        // Handwriting
                        if let data = page.drawingData,
                        let image = UIImage(data: data) {
                            Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                        }
                }
                .padding()
            }
            .navigationTitle("Saved Page")
        }
        .padding()
        .rotation3DEffect(
            .degrees(showPage ? 0 : -90),
            axis: (x: 0, y: 1, z: 0),
            anchor: .leading
        )
        .opacity(showPage ? 1 : 0)
        .animation(.easeOut(duration: 0.6), value: showPage)
        }
        .onAppear {
            showPage = true
        }
    }
}