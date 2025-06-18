import SwiftUI

extension Color {
    struct bg {
        struct main {
            static let tertiary = Color.bgMainTertiary
            // Thêm các màu khác tại đây
        }
        
        struct brand_01 {
            static let primary = Color.bgBrand01Primary
            static let tertiary = Color.bgBrand01Tertiary
        }
    }
    
    struct content {
        static let placeholder = Color.contentPlaceholder
        
        struct main {
            static let primary = Color.contentMainPrimary
        }
    }
    
    struct border {
        struct main {
            static let primary = Color.borderMainPrimary
        }
    }
}

// Sử dụng PreviewProvider để test màus
struct ColorPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            Rectangle()
                .fill(Color.bg.main.tertiary)
                .frame(width: 100, height: 100)
                .previewDisplayName("bg.main.tertiary")
        }
        .padding()
    }
} 
