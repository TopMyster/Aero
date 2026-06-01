//
//  AeroApp.swift
//  Aero
//
//  Created by Toope Oladunjoye on 6/1/26.
//

import SwiftUI

@main
struct AeroApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .toolbar(removing: .title)
                .containerBackground(.ultraThinMaterial, for: .window)
                .toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
        }
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unifiedCompact)
    }
}
