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
    @Binding var selectedDateRange: DateRange?
    let title: String

    init(title: String, selectedDateRange: Binding<DateRange?>) {
        self.title = title
        self._selectedDateRange = selectedDateRange
    }

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
                            .font(
                                Font.custom(
                                    Constants.BodyLFontFamily, size: Constants.BodyLFontSize
                                )
                                .weight(Constants.BodyLFontWeight)
                            )
                            .foregroundColor(.content.placeholder)

                        if selectedDateRange != nil {
                            Text(formattedDateRange)
                                .font(
                                    Font.custom(
                                        Constants.BodyLFontFamily, size: Constants.BodyLFontSize
                                    )
                                    .weight(Constants.BodyLFontWeight)
                                )
                                .foregroundColor(.content.main.primary)
                        }
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
            .background(.clear)
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

#Preview {
    UIDatePickerInput(title: "Ngày khởi tạo", selectedDateRange: .constant(nil))
}
