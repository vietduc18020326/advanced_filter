//
//  DebitAccount.swift
//  AdvanceFilter
//
//  Created by nhsmobile on 18/6/25.
//

import Foundation

// Model cho thông tin tài khoản trích nợ
struct DebitAccountInfo {
    let accountNumber: String
    let amount: Double
    let companyName: String

    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: amount))?.appending(" VND") ?? "0 VND"
    }
}

class DebitAccounts: BaseSelectorItems {
    required override init(items: [SelectorItem] = []) {
        // Tạo danh sách mẫu
        let accounts = [
            DebitAccountInfo(
                accountNumber: "16522713060767",
                amount: 51182007196.10,
                companyName: "CÔNG TY ĐA QUỐC GIA BẤT ĐỘNG SẢN QUỐC TẾ"
            ),
            DebitAccountInfo(
                accountNumber: "97323898483541",
                amount: 51182007196.10,
                companyName: "CÔNG TY TNHH THỜI TRANG VIỆT"
            ),
            DebitAccountInfo(
                accountNumber: "2388958534933",
                amount: 51182007196.10,
                companyName: "CÔNG TY CỔ PHẦN BẤT ĐỘNG SẢN TOÀN CẦU"
            ),
            DebitAccountInfo(
                accountNumber: "79601661381157",
                amount: 51182007196.10,
                companyName: "CÔNG TY ĐA QUỐC GIA TIẾP THỊ QUỐC TẾ"
            ),
            DebitAccountInfo(
                accountNumber: "88713465916762",
                amount: 51182007196.10,
                companyName: "CÔNG TY ĐA QUỐC GIA XÂY DỰNG QUỐC TẾ"
            ),
            DebitAccountInfo(
                accountNumber: "16037078640254",
                amount: 51182007196.10,
                companyName: "CÔNG TY CỔ PHẦN ĐẦU TƯ DỊCH VỤ MIỀN NAM"
            ),
            DebitAccountInfo(
                accountNumber: "1986821464041",
                amount: 51182007196.10,
                companyName: "CÔNG TY ĐA QUỐC GIA GIAO DỤC TOÀN CẦU"
            ),
        ]

        // Chuyển đổi thành SelectorItem
        super.init(
            items: accounts.map { account in
                SelectorItem(
                    id: account.accountNumber,
                    title: account.accountNumber,
                    data: account
                )
            }
        )
    }

    static func create(selectedIds: [String]) -> DebitAccounts {
        let instance = DebitAccounts()
        instance.initializeWithIds(selectedIds)
        return instance
    }

    static func create(selectedId: String?) -> DebitAccounts {
        let instance = DebitAccounts()
        instance.initializeWithId(selectedId)
        return instance
    }

    override var isMultiSelect: Bool {
        return false  // Chỉ cho phép chọn một tài khoản
    }
}
