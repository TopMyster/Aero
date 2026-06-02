//  TabsView.swift
//  Aero
//
//  Created by Toope Oladunjoye on 6/1/26.
//

import SwiftUI

struct TabsView: View {
    @Binding var tabs: [Tab]
    @Binding var curTab: UUID
    @Binding var showingCommandBar: Bool
    @State private var isHovering: Bool = false

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
                HStack(spacing: 0) {
                    Button {
                        if curTab != tab.id {
                            curTab = tab.id
                        }
                    } label: {
                        Text(tab.url)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .frame(maxWidth: 160, alignment: .leading)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    Button {
                        closeTab(tab.id)
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(.secondary)
                            .padding(.leading, 10)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .padding(.trailing, 12)
                    .opacity(isHovering ? 1.0 : 0.0)
                }
                .padding(.horizontal, 8)
                .background {
                    if curTab == tab.id {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white.opacity(0.25))
                            .padding(.horizontal, 6)
                            .opacity(isHovering ? 1.0 : 0.0)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .onHover { hovering in
                isHovering = hovering
            }
        }
        .padding(.top, 4)
    }

    private func closeTab(_ id: UUID) {
        if let index = tabs.firstIndex(where: { $0.id == id }) {
            if curTab == id && tabs.count > 1 {
                curTab = tabs[index == 0 ? 1 : index - 1].id
            }
            tabs.remove(at: index)
        }
    }
}
