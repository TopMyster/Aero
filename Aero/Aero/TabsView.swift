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
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .opacity(0.6)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 8)

            ForEach(tabs, id: \.id) { tab in
                Button {
                    if curTab.id != tab.id {
                        curTab = tab
                    }
                } label: {
                    Text(tab.url)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .frame(maxWidth: 180, alignment: .leading)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 8)
                .background {
                    if curTab.id == tab.id {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white.opacity(0.25))
                                .padding(.horizontal, 6)
                        }
                }
                .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
        .padding(.top, 4)
    }
}
