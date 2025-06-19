//
//  ContentView.swift
//  AdvanceFilter
//
//  Created by nhsmobile on 18/6/25.
//

import SwiftData
import SwiftUI

@available(macOS 14.0, *)
struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isShowingBottomSheet = false

    var body: some View {
        NavigationStack {
            VStack {
                Button("Show Bottom Sheet") {
                    isShowingBottomSheet.toggle()
                }
                .padding()
                .background(Color.content.placeholder)
                .foregroundColor(.white)
                .cornerRadius(10)
                .sheet(isPresented: $isShowingBottomSheet) {
                    BottomSheetView(title: "Tìm kiếm nâng cao") {
                        AdvancedFilterContent(filterForm: AdvancedFilterForm())
                    }
                }
            }
            .navigationTitle("Tìm kiếm nâng cao")
        }
    }
}

@available(macOS 14.0, *)
#Preview {
    ContentView()
}
