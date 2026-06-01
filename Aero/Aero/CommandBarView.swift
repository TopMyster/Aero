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
        TextField("Search Here...", text: $newUrl)
            .textFieldStyle(.plain)
            .padding(15)
            .frame(width: 480)
            .font(.system(size: 20))
            .background(.ultraThinMaterial)
    }
}
