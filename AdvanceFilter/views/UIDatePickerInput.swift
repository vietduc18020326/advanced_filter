//
//  UIDatePickerInput.swift
//  AdvanceFilter
//
//  Created by nhsmobile on 19/6/25.
//

import SSDateTimePicker
import SwiftUI

struct UIDatePickerInput: View {
    @State private var showDatePicker = false
    @State private var selectedDateRange: DateRange?
    let title: String

    var formattedDateRange: String {
        if let dateRange = selectedDateRange {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return
                "\(formatter.string(from: dateRange.startDate)) - \(formatter.string(from: dateRange.endDate))"
        }
        return "Ngày bắt đầu - Ngày kết thúc"
    }

    var body: some View {
        ZStack {
            Button(action: {
                showDatePicker.toggle()
            }) {
                HStack(alignment: .center, spacing: Constants.xs) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.caption)
                            .foregroundColor(.content.placeholder)

                        Text(formattedDateRange)
                            .foregroundColor(.content.main.primary)
                    }

                    Spacer()

                    Image(systemName: "chevron.down")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, Constants.s)
                .padding(.vertical, Constants.xs)
                .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .leading)
                .background(Color.clear)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 0.5)
                        .stroke(Color.border.main.primary, lineWidth: 1)
                )
            }
            
            .presentationDetents([.large]) // ❌ Chính dòng này khiến nền bị trắng
            .background(.clear)            // ❌ Không override được background sheet
        }
        .fullScreenCover(isPresented: $showDatePicker) {
            ZStack {
                Color.black.opacity(0.5).ignoresSafeArea()

                VStack {
                    SSDatePicker(showDatePicker: $showDatePicker)
                        .enableDateRangeSelection()
                        .selectedDateRange(selectedDateRange)
                        .onDateRangeSelection { dateRange in
                            selectedDateRange = dateRange
                        }
                        .background(Color.white)
                        .cornerRadius(16)
                }
            }
            .background(Color.clear)
            .overlay(.clear)
        }
    }
}

struct TransparentSheet<Content: View>: UIViewControllerRepresentable {
    let content: () -> Content

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .clear

        let hosting = UIHostingController(rootView:
            content()
                .background(Color.clear) // ✅ Quan trọng!
        )
        hosting.view.backgroundColor = .clear // ✅ Quan trọng!
        hosting.modalPresentationStyle = .overFullScreen

        DispatchQueue.main.async {
            controller.present(hosting, animated: true)
        }

        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}


#Preview {
    UIDatePickerInput(title: "Ngày khởi tạo")
}
