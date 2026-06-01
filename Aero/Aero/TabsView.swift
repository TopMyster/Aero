//
//  TabsView.swift
//  Aero
//
//  Created by Toope Oladunjoye on 6/1/26.
//

import SwiftUI

struct TabsView: View {
    @Binding var tabs: [Tab]
    @Binding var curTab: Tab
    @Binding var showingCommandBar: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {

            Button {
                showingCommandBar = true
            } label: {
                Label("New Tab", systemImage: "plus")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
            }
            .buttonStyle(.plain)
            .opacity(0.6)

            ForEach(tabs, id: \.id) { tab in
                Button {
                    if curTab.id != tab.id {
                        curTab = tab
                    }
                } label: {
                    Text(tab.url)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                }
                .buttonStyle(.plain)
                .background(
                    curTab.id == tab.id ? Color.gray.opacity(0.2) : Color.clear
                )
                .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
        .padding(.top, 4)
    }
}
