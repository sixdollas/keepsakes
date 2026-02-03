import SwiftUI
import PhotosUI

HStack(spacing: 0) {
    NotebookSpineView()
        .frame(width: 40)

        ScrollView {
            struct ScapbookPageView: View {
                @State private var journalText = ""
                @State private var selectedImage: UIImage? = nil
                @State private var selectedItem: PhotosPickerItem? = nil
                @State private var selectedImage: UIImage? = nil
                @State private var showCamera = false 
                @State private var canvas = PKCanvasView()
                @State private var stickers: [Sticker] = []
                @State private var selectedSticker: Sticker?
                @State private var photos: [PhotoItem] = []
                @State private var selectedTheme: NotebookTheme = .kraft

                @EnvironmentObject var pageStore: PageStore
                var body: some View {
                    ScrollView {
                        if pageStore.showTornEdgeOnNextPage {
                            TornEdgeView()
                                .frame(height: 60)
                                    .padding(.bottom, 10)
                            }

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
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 200)
                                    .overlay(
                                        Text("Tap to take a photo")
                                            .foregroundColor(.gray)
                                    )
                                    .onTapGesture {
                                        showCamera = true
                                    }
                                }
                            } else {
                                PhotosPicker(
                                    selection: $selectedItem,
                                    matching: .images,
                                    photoLibrary: .shared()
                                ) {
                                    Zstack {
                                        if let image = selectedImage {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFit()
                                                .cornerRadius(12)
                                        } else {
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.2))
                                                .frame(height: 200)
                                                .overlay(
                                                    Text("Tap to select a photo")
                                                        .foregroundColor(.secondary)
                                                )
                                        }
                                    }
                                }
                                .onChange(of: selectedItem) { newItems in
                                    Task {
                                        for item in newItems {
                                            if let data = try? await item.loadTransferable(type: Data.self),
                                            let uiImage = UIImage(data: data) {
                                    
                                                photos.append(
                                                    PhotosItem(
                                                        image: uiImage,
                                                        position: CGPoint(x: 150, y: 150)
                                                    )
                                                )
                                            }
                                        }
                                    }
                                }
                            }
                            // Journal Entry
                            Text("Journal Entry")
                                .font(.headline)

                            TextEditor(text: $journalText)
                                font(.custom(selectedFont.fontName, size: 20))
                                .frame(height: 200)
                                .padding(8)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(12)
                    
                            // Stickers placeholder
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Stickers")
                                    .font(.headline)

                                // Sticker Tray
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(["😀", "🎉", "❤️", "🌟", "🐶", "🍕"], id: \.self) { emoji in
                                            Text(emoji)
                                                .font(.largeTitle)
                                                .padding(8)
                                                .background(Color(.secondarySystemBackground))
                                                .cornerRadius(8)
                                                .onTapGesture {
                                                    // Add sticker anywhere on the page
                                                    stickers.append(
                                                        Sticker(
                                                            emoji: emoji,
                                                            position: CGPoint(x: 100, y: 100)
                                                        )
                                                    }
                                                }
                                            }
                                    Zstack {
                                    ForEach($stickers) { $sticker in
                                        Text(sticker.emoji)
                                            .font(.system(size: 50))
                                            .position(sticker.position)
                                            .gesture(
                                                DragGesture()
                                                    .onChanged { value in
                                                        sticker.position = value.location
                                                    }
                                            )
                                    }
                                }
                            }
                            .frame(height: 300)
                            .background(Color.yellow.opacity(0.1))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.3))
                            )

                            // Handwriting
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Handwriting")
                                    .font(.headline)
                                Button("Clear Canvas") {
                                    canvas.drawing = PKDrawing()
                                }
                                .font(.caption)
                                .foregroundColor(.blue)

                                PencilCanvasView(canvasView: $canvas)
                                    .frame(height: 200)
                                    .background(Color(.secondarySystemBackground))
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray.opacity(0.3))
                                        )
                                    }
                            }
                                    .padding()
                    }
                    .navigationTitle("Scrapbook")
                    .toolbar {
                        Button("Save") {
                            savePage()
                        }
                        Menu {
                            ForEach(NotebookTheme.all) { theme in
                                Button(theme.name) {
                                    selectedTheme = theme 
                                }
                            }
                        } label: {
                            Label("Theme", systemImage: "paintpallete")
                        }

                        //Font picker
                        Menu {
                            ForEach(CreativeFont.all) {font in
                                Button(font.name) {
                                    selectedFont = font
                                }
                            }
                        } label: {
                            Label("Font", systemImage: "textformat")
                            }
                        }
                    }
                    .sheet(isPresented: $showCamera) {
                        CameraView {image in
                            photos.append(
                                PhotoItem(
                                    image: image,
                                    position: CGPoint(x: 150, y: 150)
                                )
                            )
                        }
                        Zstack {
                            ForEach($photos) { $photo in
                                DraggablePhotoView(
                                    photo: $photo,
                                    onDelete: {
                                        if let index = photos.firstIndex(where: { $0.id == photo.id }) {
                                            photos.remove(at: index)
                                        }
                                    },
                                    onBringToFront: {
                                        // set this photo's zIndex higher than all others
                                        let maxZ = (photos.map { $0.zIndex }.max() ?? 0) + 1
                                        if let index = photos.firstIndex(where: { $0.id == photo.id }) {
                                            photos[index].zIndex = maxZ
                                        }
                                    }
                                )
                            }
                        }
            
                        func savePage() {
                            let photoCodables = photos.map { photo in
                                PhotoItemCodable(
                                    id: photo.id,
                                    imageData: photo.image.pngData() ?? Data(),
                                    positionX: photo.position.x,
                                    positionY: photo.position.y,
                                    scale: photo.scale,
                                    offsetX: photo.offset.width,
                                    offsetY: photo.offset.height,
                                    rotation: photo.rotation.radians,
                                    zIndex: photo.zIndex
                                )
                            }

                            let stickerCodables = stickers.map { sticker in
                                StickerCodable(
                                    id: sticker.id,
                                    emoji: sticker.emoji,
                                    positionX: sticker.position.x,
                                    positionY: sticker.position.y
                                )
                            }

                            let drawingData = canvas.drawing.pngData()

                            let page = ScrapbookPage(
                                id: UUID(),
                                date: Date(),
                                journalText: journalText,
                                photos: photoCodables,
                                stickers: stickerCodables,
                                drawingData: drawingData
                                )

                                pageStore.pages.append(page)
                                pageStore.save()
                                .background(
                                pageStore.showTornEdgeonNextPage = false
                            )
                            
                        }
                    }
                }
            }
        }
    }