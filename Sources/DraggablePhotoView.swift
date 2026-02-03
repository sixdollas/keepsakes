import SwiftUI

struct DraggablePhotoView: View {
    @Binding var photo: PhotoItem
    var onDelete: () -> Void
    var onBringToFront: () -> Void

    @State private var dragOffset: CGSize = .zero
    @State private var currentScale: CGFloat = 1.0
    @State private var currentRotation: Angle = .zero

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: photo.image)
                .resizable()
                .scaledToFill() // helps with crop feel
                .frame(width: 200, height: 200) // crop box size
                .clipped() // crop mask
                .cornerRadius(16) // rounded crop
                .scaleEffect(photo.scale * currentScale)
                .rotationEffect(photo.rotation + currentRotation)
                .offset(photo.offset + dragOffset)
                .position(photo.position)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation
                        }
                        .onEnded { value in
                            photo.position.x += value.translation.width
                            photo.position.y += value.translation.height
                            dragOffset = .zero
                        }
                )
                .simultaneousGesture(
                    MagnificationGesture()
                        .onChanged { value in
                            currentScale = value
                        }
                        .onEnded { value in
                            photo.scale *= value
                            currentScale = 1.0
                        }
                )
                .simultaneousGesture(
                    RotationGesture()
                        .onChanged { value in
                            currentRotation = value
                        }
                        .onEnded { value in
                            photo.rotation += currentRotation
                            currentRotation = .zero
                        }
                )
                .onTapGesture {
                    onBringToFront()
                }

            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            }
            .offset(x: -8, y: 8)
        }
        .zIndex(photo.zIndex)
    }
}
}