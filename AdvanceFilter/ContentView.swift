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
    @StateObject private var filterForm = AdvancedFilterForm()

    var body: some View {
        NavigationStack {
            VStack {
                Button("Show Bottom Sheet") {
                    filterForm.initialize()
                    isShowingBottomSheet.toggle()
                }
                .padding()
                .background(Color.content.placeholder)
                .foregroundColor(.white)
                .cornerRadius(10)
                .sheet(isPresented: $isShowingBottomSheet) {
                    BottomSheetView(
                        title: "Tìm kiếm nâng cao",
                        onLeftButtonTapped: {
                            filterForm.reset()
                        },
                        onRightButtonTapped: {
                            filterForm.apply()
                            isShowingBottomSheet.toggle()
                        }
                    ) {
                        AdvancedFilterContent(filterForm: filterForm)
                    }
                    .onDisappear() {
                        filterForm.reset()
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
