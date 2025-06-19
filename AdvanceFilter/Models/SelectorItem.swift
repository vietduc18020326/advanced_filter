//
//  SelectorItem.swift
//  SelectorItem
//
//  Created by nhsmobile on 18/6/25.
//

import Foundation

/// Model representing an item that can be selected in selector filter
class SelectorItem: Identifiable {
    /// Unique identifier for the item
    let id: String

    /// The title/name to display
    let title: String

    /// Optional subtitle or description
    let subtitle: String?

    /// Whether the item is currently selected
    var isSelected: Bool

    /// Optional icon name (SF Symbols)
    let iconName: String?

    var data: Any?

    init(
        id: String,
        title: String,
        subtitle: String? = nil,
        isSelected: Bool = false,
        iconName: String? = nil,
        data: Any? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.isSelected = isSelected
        self.iconName = iconName
        self.data = data
    }

    /// Toggle the selection state of this item
    func toggleSelection() {
        isSelected.toggle()
    }

    /// Set the selection state of this item
    func setSelected(_ selected: Bool) {
        isSelected = selected
    }
}

// MARK: - Equatable
extension SelectorItem: Equatable {
    static func == (lhs: SelectorItem, rhs: SelectorItem) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Hashable
extension SelectorItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Example Usage
extension SelectorItem {
    /// Create a sample supplier item
    static func createItem(
        id: String,
        name: String,
        code: String? = nil,
        isSelected: Bool = false,
        data: Any? = nil
    ) -> SelectorItem {
        return SelectorItem(
            id: id,
            title: name,
            subtitle: code,
            isSelected: isSelected,
            iconName: "building.2",
            data: data
        )
    }
}
