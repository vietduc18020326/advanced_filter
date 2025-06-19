//
//  Status.swift
//  AdvanceFilter
//
//  Created by nhsmobile on 18/6/25.
//

import Foundation

// CaseIterable cho phép chúng ta duyệt qua tất cả các cases của enum
enum StatusType: CaseIterable {
    case all
    case new
    case rejected
    case pending
    case approved
    case undefined
    case failed
    case processing
    case expired

    var displayText: String {
        switch self {
        case .all: return "Tất cả"
        case .new: return "Tạo mới"
        case .rejected: return "Từ chối duyệt"
        case .pending: return "Chờ duyệt"
        case .approved: return "Thành công"
        case .undefined: return "Chưa xác định"
        case .failed: return "Không thành công"
        case .processing: return "Ngân hàng xử lý"
        case .expired: return "Hết hiệu lực"
        }
    }

    var id: String {
        switch self {
        case .all: return "ALL"
        case .new: return "NEW"
        case .rejected: return "REJECTED"
        case .pending: return "PENDING"
        case .approved: return "APPROVED"
        case .undefined: return "UNDEFINED"
        case .failed: return "FAILED"
        case .processing: return "PROCESSING"
        case .expired: return "EXPIRED"
        }
    }
}

class Status: BaseSelectorItems {
    required override init(items: [SelectorItem] = []) {
        super.init(
            items: StatusType.allCases.map { type in
                SelectorItem(
                    id: type.id,
                    title: type.displayText
                )
            }
        )
    }

    static func create(selectedIds: [String]) -> Status {
        let instance = Status()
        instance.initializeWithIds(selectedIds)
        return instance
    }

    static func create(selectedId: String?) -> Status {
        let instance = Status()
        instance.initializeWithId(selectedId)
        return instance
    }

    override var isMultiSelect: Bool {
        return false
    }
}
