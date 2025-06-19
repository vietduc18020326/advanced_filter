import SwiftUI

struct BottomSheetView<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    let content: Content
    let hideBottomButtons: Bool
    @State private var detentHeight: CGFloat = 0

    init(title: String, hideBottomButtons: Bool = false, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
        self.hideBottomButtons = hideBottomButtons
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
         .readHeight()
         .onPreferenceChange(HeightPreferenceKey.self) { height in
             if let height {
                 self.detentHeight = height
             }
         }
         .presentationDetents([.height(self.detentHeight)])
    }
}

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat?

    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        guard let nextValue = nextValue() else { return }
        value = nextValue
    }
}

private struct ReadHeightModifier: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(
                key: HeightPreferenceKey.self,
                value: geometry.size.height)
        }
    }

    func body(content: Content) -> some View {
        content.background(sizeView)
    }
}

extension View {
    func readHeight() -> some View {
        self.modifier(ReadHeightModifier())
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
