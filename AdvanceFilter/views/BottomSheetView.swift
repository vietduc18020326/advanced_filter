import SwiftUI

struct BottomSheetView<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    let content: Content
    let hideBottomButtons: Bool
    let onLeftButtonTapped: (() -> Void)?
    let onRightButtonTapped: (() -> Void)?

    // MARK: - Local Height Management
    // Sử dụng local state để track height, không dùng preference keys
    @State private var detentHeight: CGFloat = 400  // Default fallback height
    @State private var selectedDetent: PresentationDetent = .height(400)

    init(
        title: String,
        hideBottomButtons: Bool = false,
        onLeftButtonTapped: (() -> Void)? = nil,
        onRightButtonTapped: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.hideBottomButtons = hideBottomButtons
        self.content = content()
        self.onLeftButtonTapped = onLeftButtonTapped
        self.onRightButtonTapped = onRightButtonTapped
    }

    var titleView: some View {
        Text(title)
            .font(.headline)
            .fontWeight(.semibold)
    }

    var xmarkButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.content.main.primary)
        }
        .padding(.all, 10)
    }

    //@ViewBuilder giúp trả về EmptyView ngầm định nếu if không thỏa điều kiện.
    @ViewBuilder
    var bottomButtons: some View {
        if !hideBottomButtons {
            Group {
                HStack(spacing: 16) {
                    Button(action: {
                        onLeftButtonTapped?()
                    }) {
                        Text("Xoá bộ lọc")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.content.main.primary)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 0.5)
                                    .stroke(Color.border.main.primary, lineWidth: 1)
                            )
                    }

                    Button(action: {
                        onRightButtonTapped?()
                    }) {
                        Text("Áp dụng")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.bg.brand_01.primary)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
        }
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: Constants.s) {
                HStack {
                    titleView

                    Spacer()

                    xmarkButton
                }
                .frame(maxWidth: .infinity)
                .padding(.leading, Constants.xs)
                .padding(.trailing, 4)

                content

            }
            .frame(maxWidth: .infinity, alignment: .top)
            .padding(.horizontal, Constants.xs)
            .padding(.top, 8)
            .background(Color.bg.main.tertiary)

            bottomButtons
        }
        .frame(maxWidth: .infinity)
        .background(
            // MARK: - Local Height Measurement
            // Đo height trực tiếp bằng GeometryReader local, không dùng preference keys
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        let height = geometry.size.height
                        let validHeight = max(height, 200)  // Min height = 200
                        let maxHeight = UIScreen.main.bounds.height * 0.9  // Max height = 90% màn hình
                        let finalHeight = min(validHeight, maxHeight)

                        self.detentHeight = finalHeight
                    }
                    .onChange(of: geometry.size.height) { newHeight in
                        let validHeight = max(newHeight, 200)
                        let maxHeight = UIScreen.main.bounds.height * 0.9
                        let finalHeight = min(validHeight, maxHeight)

                        self.detentHeight = finalHeight
                    }
            }
        )
        .presentationDetents([.height(self.detentHeight)], selection: $selectedDetent)
    }
}

#Preview {
    BottomSheetView(title: "Preview Sheet") {
        VStack(alignment: .leading, spacing: 16) {
            Text("Custom Content")
                .font(.headline)

            Text("This is content passed from outside")
                .foregroundColor(.secondary)

            Button("Sample Button") {
                print("Button tapped")
            }
            .buttonStyle(.bordered)
        }
    }
}
