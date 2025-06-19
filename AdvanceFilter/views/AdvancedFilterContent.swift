//
//  AdvancedFilterContent.swift
//  AdvanceFilter
//
//  Created by nhsmobile on 18/6/25.
//

import SwiftUICore

struct AdvancedFilterContent: View {
    let suppliers: Suppliers
    let services: Services
    let status: Status
    let registerType: Register
    let debitAccounts: DebitAccounts

    init(filterForm: AdvancedFilterForm) {
        self.suppliers = Suppliers.create(selectedId: filterForm.supplierId)
        self.services = Services.create(selectedId: filterForm.serviceId)
        self.status = Status.create(selectedId: filterForm.status)
        self.registerType = Register.create(selectedId: filterForm.registerType)
        self.debitAccounts = DebitAccounts.create(selectedId: filterForm.debit)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            UISelectorInput(title: "Nhà cung cấp", data: suppliers, isSearch: true)
            UISelectorInput(title: "Dịch vụ", data: services, isSearch: true)
            UISelectorInput(title: "Trạng thái", data: status)
            UISelectorInput(title: "Loại đăng ký", data: registerType)

            UISelectorInput(
                title: "Tài khoản trích nợ",
                data: debitAccounts,
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

            UIDatePickerInput(title: "Ngày khởi tạo")
        }
        .padding(.horizontal, Constants.xs)
    }
}
