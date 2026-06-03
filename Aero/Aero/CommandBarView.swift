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
        .transition(.move(edge: .bottom))
        .frame(width: 480)
        .font(.system(size: 20))
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.gray, lineWidth: 0.5)
        )
        .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 2)
    }
}
