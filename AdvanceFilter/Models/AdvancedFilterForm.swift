class AdvancedFilterForm {
    var supplierId: String?
    var serviceId: String?
    var status: String?
    var registerType: String?
    var debit: String?

    init(
        supplierId: String? = nil, serviceId: String? = nil, status: String? = nil,
        registerType: String? = nil, debit: String? = nil
    ) {
        self.supplierId = supplierId
        self.serviceId = serviceId
        self.status = status
        self.registerType = registerType
        self.debit = debit
    }
}
