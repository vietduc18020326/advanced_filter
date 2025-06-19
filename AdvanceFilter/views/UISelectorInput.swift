//
//  UISelectorInput.swift
//  AdvanceFilter
//
//  Created by nhsmobile on 18/6/25.
//

import SwiftUI

struct UISelectorInput: View {
    @State private var isShowingBottomSheet = false
    @State private var searchText = ""
    @StateObject private var data: BaseSelectorItems

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
        self._data = StateObject(wrappedValue: data)
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

                // List items
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
            }
        }
    }

    var body: some View {
        Button(action: {
            isShowingBottomSheet.toggle()
        }) {
            HStack(alignment: .center, spacing: Constants.xs) {
                Text(displayText)
                    .foregroundColor(.content.main.primary)

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
