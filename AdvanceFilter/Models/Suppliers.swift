//
//  Suppliers.swift
//  AdvanceFilter
//
//  Created by nhsmobile on 18/6/25.
//

import Foundation

class Suppliers: BaseSelectorItems {
    required override init(items: [SelectorItem] = []) {
        super.init(
            items: [
                SelectorItem.createItem(id: "1", name: "VNPT"),
                SelectorItem.createItem(id: "2", name: "FPT"),
                SelectorItem.createItem(id: "3", name: "EVN"),
                SelectorItem.createItem(id: "4", name: "VIETTEL"),
                SelectorItem.createItem(id: "5", name: "MOBI PHONE"),
                SelectorItem.createItem(id: "6", name: "GMOBILE"),
                SelectorItem.createItem(id: "7", name: "I-TELECOME"),
                SelectorItem.createItem(id: "8", name: "DICHVU"),
                SelectorItem.createItem(id: "9", name: "MOP"),
                SelectorItem.createItem(id: "10", name: "AOA"),
                SelectorItem.createItem(id: "11", name: "BHD"),
                SelectorItem.createItem(id: "12", name: "MRU"),
            ])
    }

    /// Tạo instance mới với các item đã được chọn
    static func create(selectedIds: [String]) -> Suppliers {
        let instance = Suppliers()
        instance.initializeWithIds(selectedIds)
        return instance
    }

    /// Tạo instance mới với một item đã được chọn
    static func create(selectedId: String?) -> Suppliers {
        let instance = Suppliers()
        instance.initializeWithId(selectedId)
        return instance
    }

    override var isMultiSelect: Bool {
        return false
    }
}
