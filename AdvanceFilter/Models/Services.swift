//
//  Services.swift
//  AdvanceFilter
//
//  Created by nhsmobile on 18/6/25.
//

import Foundation

class Services: BaseSelectorItems {
    required override init(items: [SelectorItem] = []) {
        super.init(
            items: [
                SelectorItem(id: "1", title: "Học phí lệ phí", iconName: "graduationcap"),
                SelectorItem(
                    id: "2", title: "Nộp tiền chứng khoán", iconName: "chart.line.uptrend.xyaxis"),
                SelectorItem(id: "3", title: "Bảo hiểm", iconName: "cross.case"),
                SelectorItem(id: "4", title: "Tiền điện", iconName: "bolt"),
                SelectorItem(id: "5", title: "Tiền nước", iconName: "drop"),
                SelectorItem(id: "6", title: "Bảo hiểm BIC", iconName: "cross"),
                SelectorItem(id: "7", title: "Vé máy bay", iconName: "airplane"),
                SelectorItem(id: "8", title: "Học phí", iconName: "book"),
                SelectorItem(id: "9", title: "Truyền hình", iconName: "tv"),
                SelectorItem(id: "10", title: "Vé tàu", iconName: "train.side.front.car"),
            ])
    }

    static func create(selectedIds: [String]) -> Services {
        let instance = Services()
        instance.initializeWithIds(selectedIds)
        return instance
    }

    static func create(selectedId: String?) -> Services {
        let instance = Services()
        instance.initializeWithId(selectedId)
        return instance
    }

    override var isMultiSelect: Bool {
        return false
    }
}
