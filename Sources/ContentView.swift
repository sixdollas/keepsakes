import SwiftUI

struct ScapbookPageView: View {
    @State private var journalText = ""
    @State private var selectedImage: UIImage? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Date Header
                Text(Date.now.formatted(date: .long, time: .omitted))
                    .font(.title)
                    .bold()

                // Photo Section
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                } else {
                    Rectangle()
                        .fill(Colow.gray.opacity(0.2))
                        .frame(height: 200)
                        .overlay(
                            Text("Tap to add a photo")
                                .foregroundColor(.gray)
                        )
                        .onTapGesture {
                            // open camera or gallery
                        }
                }
                // Journal Entry
                Text("Journal Entry")
                    .font(.headline)

                TextEditor(text: $journalText)
                    .frame(height: 200)
                    .padding(8)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    
                // Stickers placeholder
                VStack(alignment: .loading) {
                    Text("Stickers")
                        .font(.headline)

                    Rectangle()
                        .fill(Color.yellow.opacity(0.2))
                        .frame(height: 120)
                        .cornerRadius(12)
                        .overlay(Text("Sticker canvas"))
                }

                // Handwriting palceholder
                VStack(alignment: .leading) {
                    Text("Handwriting")
                        .font(.headline)

                    Rectangle()
                        .fill(Color.blue.opacity(0.1))
                        .frame(height: 200)
                        .cornerRadius(12)
                        .overlay(Text("PencilKit canvas"))
                }
            }
            .padding()
        }
        .navigationTitle("Scrapbook")
    }
}