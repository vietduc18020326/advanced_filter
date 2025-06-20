//
//  UISelectorInput.swift
//  AdvanceFilter
//
//  Created by nhsmobile on 18/6/25.
//

import SwiftUI

struct UISelectorInput: View {
    // MARK: - State Management
    @State private var isShowingBottomSheet = false
    @State private var searchText = ""

    // Lưu trữ chiều cao thực tế của nội dung list
    // Được tính toán từ VStack ẩn để đảm bảo bottom sheet chỉ scroll khi cần thiết
    @State private var contentHeight: CGFloat = 0

    // MARK: - Data Management
    // Sử dụng @ObservedObject để listen to changes từ bên ngoài
    @ObservedObject var data: BaseSelectorItems

    // MARK: - Configuration
    let title: String
    let isSearch: Bool
    let itemContent: ((SelectorItem) -> AnyView)?
    var onSelectionChanged: (([SelectorItem]) -> Void)?

    init(
        title: String,
        data: BaseSelectorItems,
        isSearch: Bool = false,
        itemContent: ((SelectorItem) -> AnyView)? = nil,
        onSelectionChanged: (([SelectorItem]) -> Void)? = nil
    ) {
        self.title = title
        self.data = data
        self.isSearch = isSearch
        self.itemContent = itemContent
        self.onSelectionChanged = onSelectionChanged
    }

    var selectedItems: [SelectorItem] {
        return data.getSelectedItems()
    }

    var filteredItems: [SelectorItem] {
        return data.searchItems(query: searchText)
    }

    var displayText: String {
        let selected = selectedItems
        if selected.isEmpty {
            return title
        }
        if selected.count == 1 {
            return selected[0].title
        }
        return "\(selected.count) selected"
    }

    var selectorBottomSheet: some View {
        BottomSheetView(title: title, hideBottomButtons: true) {
            VStack(alignment: .leading, spacing: Constants.s) {
                if isSearch {
                    UISearchInput(text: $searchText)
                        .padding(.horizontal, Constants.xs)
                }

                // MARK: - Smart Scrolling System
                // ScrollView chính để hiển thị list items với LazyVStack (hiệu năng tốt)
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(filteredItems) { item in
                            ItemRow(item: item, itemContent: itemContent) {
                                data.toggleSelection(for: item.id)
                                onSelectionChanged?(selectedItems)
                            }
                        }
                    }
                }
                // Điều chỉnh maxHeight thông minh:
                // - Nếu đã có contentHeight (đo từ VStack ẩn): sử dụng height thực tế
                // - Fallback: ước tính 72px cho mỗi item
                // - Giới hạn tối đa: 80% chiều cao màn hình để tránh bottom sheet quá cao
                .frame(
                    maxHeight: min(
                        contentHeight > 0 ? contentHeight : CGFloat(filteredItems.count) * 72,
                        UIScreen.main.bounds.height * 0.8)
                )
                .background(
                    // MARK: - Height Measurement System (Local)
                    // VStack ẩn để đo chiều cao thực tế của tất cả items nội bộ
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(filteredItems) { item in
                            ItemRow(item: item, itemContent: itemContent) {
                                // Empty action vì đây chỉ để đo height, không tương tác
                            }
                        }
                    }
                    .background(
                        // GeometryReader để đo kích thước VStack ẩn (local measurement)
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    self.contentHeight = geometry.size.height
                                }
                        }
                    )
                    .hidden()  // Ẩn VStack này - chỉ để đo height
                )
            }
        }
        .onDisappear() {
            searchText = ""
        }
    }

    var body: some View {
        Button(action: {
            isShowingBottomSheet.toggle()
        }) {
            HStack(alignment: .center, spacing: Constants.xs) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(
                            Font.custom(Constants.BodyLFontFamily, size: Constants.BodyLFontSize)
                                .weight(Constants.BodyLFontWeight)
                        )
                        .foregroundColor(.content.placeholder)

                    if !selectedItems.isEmpty {
                        Text(displayText)
                            .font(
                                Font.custom(
                                    Constants.BodyLFontFamily, size: Constants.BodyLFontSize
                                )
                                .weight(Constants.BodyLFontWeight)
                            )
                            .foregroundColor(.content.main.primary)
                    }
                }

                Spacer()

                Image(systemName: "chevron.down")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, Constants.s)
            .padding(.vertical, Constants.xs)
            .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .leading)
            .background(Color.clear)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.5)
                    .stroke(Color.border.main.primary, lineWidth: 1)
            )
        }
        .sheet(isPresented: $isShowingBottomSheet) {
            selectorBottomSheet
        }
    }
}

// MARK: - ItemRow
private struct ItemRow: View {
    let item: SelectorItem
    let onTap: () -> Void
    let itemContent: ((SelectorItem) -> AnyView)?
    @State private var isTapped = false

    init(
        item: SelectorItem,
        itemContent: ((SelectorItem) -> AnyView)? = nil,
        onTap: @escaping () -> Void
    ) {
        self.item = item
        self.itemContent = itemContent
        self.onTap = onTap
    }

    var body: some View {
        HStack(spacing: Constants.s) {
            if let customContent = itemContent {
                customContent(item)
            } else {
                if let iconName = item.iconName {
                    Image(systemName: iconName)
                        .foregroundColor(.content.main.primary)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .foregroundColor(.content.main.primary)
                    if let subtitle = item.subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }

            Spacer()

            if item.isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
        .padding(.horizontal, Constants.xs)
        .padding(.vertical, Constants.m)
        .background(item.isSelected ? Color.bg.brand_01.tertiary : Color.white)
        .cornerRadius(8)
        .simultaneousGesture(
            // Phát hiện drag để hủy tap
            DragGesture(minimumDistance: 5)
                .onChanged { _ in
                    isTapped = false
                }
        )
        .simultaneousGesture(
            // Phát hiện tap để toggle selection
            TapGesture()
                .onEnded {
                    isTapped = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isTapped = false
                        onTap()
                    }
                }
        )
    }
}

#Preview {
    let suppliers = Suppliers()
    return UISelectorInput(
        title: "Nhà cung cấp",
        data: suppliers,
        isSearch: true
    )
}
