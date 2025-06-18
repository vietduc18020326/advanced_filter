//
//  BaseAdvancedFilter.swift
//  AdvanceFilter
//
//  Created by nhsmobile on 18/6/25.
//

import Foundation

class BaseSelectorItems: ObservableObject {
    // Cần thay đổi shared từ let thành var để có thể gán lại giá trị
    static var shared: BaseSelectorItems = BaseSelectorItems()

    @Published var items: [SelectorItem] = []

    // Cho phép class con override để quyết định có cho phép chọn nhiều hay không
    var isMultiSelect: Bool {
        return true  // Mặc định cho phép multi select
    }

    init(items: [SelectorItem] = []) {
        self.items = items
    }

    /// Khởi tạo với danh sách ID của các item đã được chọn
    func initializeWithIds(_ selectedIds: [String]) {
        // Set trạng thái selected cho các item có id nằm trong selectedIds
        items.forEach { item in
            if selectedIds.contains(item.id) {
                item.setSelected(true)
            }
        }
    }

    /// Khởi tạo với một ID đã được chọn
    func initializeWithId(_ selectedId: String?) {
        if let id = selectedId {
            initializeWithIds([id])
        }
    }

    func getItems() -> [SelectorItem] {
        return items
    }

    func getSelectedItems() -> [SelectorItem] {
        return items.filter { $0.isSelected }
    }

    /// Lấy danh sách ID của các item đã chọn
    func getSelectedIds() -> [String] {
        return items.filter { $0.isSelected }.map { $0.id }
    }

    func toggleSelection(for id: String) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            // Nếu không phải multiSelect và item này chưa được chọn
            if !isMultiSelect && !items[index].isSelected {
                // Bỏ chọn tất cả các item khác
                clearAllSelections()
            }

            // Toggle selection cho item được chọn
            let updatedItem = items[index]
            updatedItem.toggleSelection()
            items[index] = updatedItem
            objectWillChange.send()  // thông báo cho SwiftUI biết có thay đổi
        }
    }

    func clearAllSelections() {
        items = items.map { item in
            let updatedItem = item
            updatedItem.setSelected(false)
            return updatedItem
        }
        objectWillChange.send()
    }

    func searchItems(query: String) -> [SelectorItem] {
        if query.isEmpty {
            return items
        }
        return items.filter { $0.title.lowercased().contains(query.lowercased()) }
    }

    // Kiểm tra xem có thể chọn thêm item không
    func canSelectMore() -> Bool {
        return isMultiSelect || getSelectedItems().isEmpty
    }

    // Lấy số lượng item tối đa có thể chọn
    func getMaxSelectCount() -> Int {
        return isMultiSelect ? items.count : 1
    }
}
