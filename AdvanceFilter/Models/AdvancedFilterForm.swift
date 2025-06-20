import SSDateTimePicker
import SwiftUI

class AdvancedFilterForm: ObservableObject {
    // MARK: - ID Properties (for backend)
    var supplierId: String?
    var serviceId: String?
    var status: String?
    var registerType: String?
    var debit: String?
    var startDate: Date?
    var endDate: Date?

    // MARK: - Selector Data Properties (for UI binding)
    @Published var suppliers: Suppliers
    @Published var services: Services
    @Published var statusData: Status
    @Published var registerTypeData: Register
    @Published var debitAccounts: DebitAccounts
    @Published var initializationTimeRange: DateRange?

    init(
        supplierId: String? = nil, serviceId: String? = nil, status: String? = nil,
        registerType: String? = nil, debit: String? = nil, startDate: Date? = nil,
        endDate: Date? = nil
    ) {
        self.supplierId = supplierId
        self.serviceId = serviceId
        self.status = status
        self.registerType = registerType
        self.debit = debit
        self.startDate = startDate
        self.endDate = endDate

        // Initialize selector data with current IDs
        self.suppliers = Suppliers.create(selectedId: supplierId)
        self.services = Services.create(selectedId: serviceId)
        self.statusData = Status.create(selectedId: status)
        self.registerTypeData = Register.create(selectedId: registerType)
        self.debitAccounts = DebitAccounts.create(selectedId: debit)

        if let start = startDate, let end = endDate {
            self.initializationTimeRange = (startDate: start, endDate: end)
        }
    }

    func reset() {
        // Clear existing objects thay vì tạo mới để giữ @ObservedObject connections
        suppliers.clearAllSelections()
        services.clearAllSelections()
        statusData.clearAllSelections()
        registerTypeData.clearAllSelections()
        debitAccounts.clearAllSelections()
        initializationTimeRange = nil

        objectWillChange.send()
    }

    func apply() {
        supplierId = suppliers.getSelectedIds().first
        serviceId = services.getSelectedIds().first
        status = statusData.getSelectedIds().first
        registerType = registerTypeData.getSelectedIds().first
        debit = debitAccounts.getSelectedIds().first
        startDate = initializationTimeRange?.startDate
        endDate = initializationTimeRange?.endDate
    }

    func initialize() {
        suppliers.initializeWithId(supplierId)
        services.initializeWithId(serviceId)
        statusData.initializeWithId(status)
        registerTypeData.initializeWithId(registerType)
        debitAccounts.initializeWithId(debit)
        
        if let start = startDate, let end = endDate {
            self.initializationTimeRange = (startDate: start, endDate: end)
        }

        objectWillChange.send()
    }
}
