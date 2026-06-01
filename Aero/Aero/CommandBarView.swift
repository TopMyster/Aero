//
//  CommandBarView.swift
//  Aero
//
//  Created by Toope Oladunjoye on 6/1/26.
//

import SwiftUI

struct CommandBarView: View {
    @Binding var newUrl: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(10)
            TextField("Search Here...", text: $newUrl)
                .textFieldStyle(.plain)
        }
        .frame(width: 480)
        .font(.system(size: 18))
        .background(.ultraThinMaterial)
        .shadow(radius: 15)
    }
}
