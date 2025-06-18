//
//  AdvanceFilterApp.swift
//  AdvanceFilter
//
//  Created by nhsmobile on 18/6/25.
//

import SwiftUI
import SwiftData

@available(macOS 14.0, *)
@main
struct AdvanceFilterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
        }
    }
}
