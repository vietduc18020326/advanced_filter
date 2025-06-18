import SwiftUI

struct BottomSheetView<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
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
    }

    var bottomButtons: some View {
        HStack(spacing: 16) {
            Button(action: {
                print("Button tapped")
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
                print("Button tapped")
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

    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: Constants.s) {
                    content

                    Spacer()  // Đẩy nội dung lên trên
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, Constants.m)
                .padding(.top, 8)
                .background(Color.bg.main.tertiary)

                bottomButtons
            }
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                // Title ở bên trái
                #if os(iOS)
                    ToolbarItem(placement: .navigationBarLeading) {
                        titleView
                    }
                #else
                    ToolbarItem(placement: .cancellationAction) {
                        titleView
                    }
                #endif

                // Done button ở bên phải
                #if os(iOS)
                    ToolbarItem(placement: .navigationBarTrailing) {
                        xmarkButton
                    }
                #else
                    ToolbarItem(placement: .primaryAction) {
                        xmarkButton
                    }
                #endif
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
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
