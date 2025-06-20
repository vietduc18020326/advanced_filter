//
//  AdvancedFilterContent.swift
//  AdvanceFilter
//
//  Created by nhsmobile on 18/6/25.
//

import SwiftUICore

struct AdvancedFilterContent: View {
    @ObservedObject var filterForm: AdvancedFilterForm

    init(filterForm: AdvancedFilterForm) {
        self.filterForm = filterForm
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            UISelectorInput(
                title: "Nhà cung cấp",
                data: filterForm.suppliers,
                isSearch: true
            )

            UISelectorInput(
                title: "Dịch vụ",
                data: filterForm.services,
                isSearch: true
            )

            UISelectorInput(
                title: "Trạng thái",
                data: filterForm.statusData
            )

            UISelectorInput(
                title: "Loại đăng ký",
                data: filterForm.registerTypeData
            )

            UISelectorInput(
                title: "Tài khoản trích nợ",
                data: filterForm.debitAccounts,
                isSearch: true,
                itemContent: { item in
                    if let account = item.data as? DebitAccountInfo {
                        return AnyView(
                            HStack(spacing: 12) {
                                Image(systemName: "creditcard")
                                    .font(.system(size: 20))
                                    .foregroundColor(.content.main.primary)
                                    .frame(width: 32, height: 32)
                                    .background(.bgNonOpaqueDefault)
                                    .cornerRadius(.infinity)

                                VStack(alignment: .leading, spacing: Constants.none) {
                                    Text(account.accountNumber)
                                        .foregroundColor(.content.main.primary)
                                    Text(account.formattedAmount)
                                        .font(.caption)
                                        .foregroundColor(.content.main.tertiary)
                                    Text(account.companyName)
                                        .font(.caption)
                                        .foregroundColor(.content.main.tertiary)
                                        .lineLimit(1)
                                }
                            }
                        )
                    } else {
                        return AnyView(EmptyView())
                    }
                }
            )

            UIDatePickerInput(
                title: "Ngày khởi tạo",
                selectedDateRange: $filterForm.initializationTimeRange
            )
        }
        .padding(.horizontal, Constants.xs)
    }
}
