//
//  AdvancedFilterContent.swift
//  AdvanceFilter
//
//  Created by nhsmobile on 18/6/25.
//

import SwiftUICore

struct AdvancedFilterContent: View {
    let suppliers: Suppliers

    init(filterForm: AdvancedFilterForm) {
        self.suppliers = Suppliers.create(selectedId: filterForm.supplierId)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            UISelectorInput(title: "Nhà cung cấp", data: suppliers, isSearch: true)
        }
    }
}
