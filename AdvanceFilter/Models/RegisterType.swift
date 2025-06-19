//
//  RegisterType.swift
//  AdvanceFilter
//
//  Created by nhsmobile on 18/6/25.
//

import Foundation

enum RegisterType: CaseIterable {
    case all
    case new
    case change
    case cancel

    var displayText: String {
        switch self {
        case .all: return "Tất cả"
        case .new: return "Đăng ký mới"
        case .change: return "Thay đổi"
        case .cancel: return "Huỷ"
        }
    }

    var id: String {
        switch self {
        case .all: return "ALL"
        case .new: return "NEW"
        case .change: return "CHANGE"
        case .cancel: return "CANCEL"
        }
    }
}

class Register: BaseSelectorItems {
    required override init(items: [SelectorItem] = []) {
        super.init(
            items: RegisterType.allCases.map { type in
                SelectorItem(
                    id: type.id,
                    title: type.displayText
                )
            }
        )
    }

    static func create(selectedIds: [String]) -> Register {
        let instance = Register()
        instance.initializeWithIds(selectedIds)
        return instance
    }

    static func create(selectedId: String?) -> Register {
        let instance = Register()
        instance.initializeWithId(selectedId)
        return instance
    }

    override var isMultiSelect: Bool {
        return false
    }
}
