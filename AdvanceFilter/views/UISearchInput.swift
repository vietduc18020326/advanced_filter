//
//  UISearchInput.swift
//  AdvanceFilter
//
//  Created by nhsmobile on 18/6/25.
//

import SwiftUI

struct UISearchInput: View {
    @Binding var text: String
    let placeholder: String
    let onSearchButtonClicked: (() -> Void)?
    let onTextChanged: ((String) -> Void)?
    let debounceTime: TimeInterval

    @State private var internalText: String = ""
    @State private var debounceTimer: Timer?

    init(
        text: Binding<String>,
        placeholder: String = "Tìm kiếm...",
        debounceTime: TimeInterval = 0.5,
        onSearchButtonClicked: (() -> Void)? = nil,
        onTextChanged: ((String) -> Void)? = nil
    ) {
        // _text (với underscore): Truy cập property wrapper trực tiếp
        // text (không underscore): Chỉ truy cập value, không phải binding
        self._text = text
        self.placeholder = placeholder
        self.debounceTime = debounceTime
        self.onSearchButtonClicked = onSearchButtonClicked
        self.onTextChanged = onTextChanged
    }

    var body: some View {
        HStack(alignment: .center, spacing: Constants.xs) {
            // Search icon
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.secondary)

            // Text field
            TextField(placeholder, text: $internalText)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.system(size: 16))
                .foregroundColor(.primary)
                .submitLabel(.search)  // Hiển thị "Search" button trên keyboard
                .onSubmit {
                    onSearchButtonClicked?()
                }
                .onChange(of: internalText) { _, newValue in
                    // Cancel previous timer
                    debounceTimer?.invalidate()

                    // Start new timer for debounce
                    debounceTimer = Timer.scheduledTimer(
                        withTimeInterval: debounceTime, repeats: false
                    ) { _ in
                        // Update the binding after debounce
                        text = newValue
                        onTextChanged?(newValue)
                    }
                }

            // Clear button (only show when text is not empty)
            if !internalText.isEmpty {
                Button {
                    internalText = ""
                    text = ""  // Immediately clear both
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.red)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, Constants.s)
        .padding(.vertical, Constants.xs)
        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
        .background(Color.clear)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .inset(by: 0.5)
                .stroke(Color.border.main.primary, lineWidth: 1)
        )
        .onAppear {
            // Sync internal text with binding on appear
            internalText = text
        }
        .onChange(of: text) { _, newValue in
            // Update internal text if external binding changes
            if internalText != newValue {
                internalText = newValue
            }
        }
    }
}

#Preview {
    @Previewable @State var searchText = ""

    VStack(spacing: 16) {
        Text("Current debounced value: '\(searchText)'")
            .font(.caption)
            .foregroundColor(.secondary)

        UISearchInput(
            text: $searchText,
            placeholder: "Type to see debounce...",
            debounceTime: 0.8
        )

        UISearchInput(
            text: $searchText,
            placeholder: "Fast debounce (0.3s)",
            debounceTime: 0.3,
            onSearchButtonClicked: {
                print("🔍 Search submitted: '\(searchText)'")
            }
        )
    }
    .padding()
}
