import SwiftUI

struct ContentView: View {
    @State private var showingCommandBar = false
    @State private var newUrl = ""
    @State private var tabs: [Tab] = []
    @State private var curTab: UUID = UUID()

    var currentIndex: Int? {
        tabs.firstIndex { $0.id == curTab }
    }

    var body: some View {
        ZStack(alignment: .center) {
            HStack(spacing: 0) {

                VStack(alignment: .center) {

                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)

                        TextField("Search", text: $newUrl)
                            .onSubmit {

                                var formatted: String

                                if newUrl.hasPrefix("http://") || newUrl.hasPrefix("https://") {
                                    formatted = newUrl
                                } else if newUrl.contains(".") {
                                    formatted = "https://" + newUrl
                                } else {
                                    let query = newUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                    formatted = "https://www.google.com/search?q=\(query)"
                                }

                                if let index = tabs.firstIndex(where: { $0.id == curTab }) {
                                    tabs[index].url = formatted
                                    newUrl = formatted
                                }
                            }
                    }
                    .textFieldStyle(.plain)
                    .frame(width: 165, height: 30)
                    .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 6))
                    .background(.white.opacity(0.08))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(5)

                    ScrollView {
                        TabsView(
                            tabs: $tabs,
                            curTab: $curTab,
                            showingCommandBar: $showingCommandBar
                        )
                    }

                    Spacer()
                }
                .frame(width: 200)
                .frame(maxHeight: .infinity, alignment: .topLeading)
                ZStack {
                    ForEach(tabs) { tab in
                        tab.webView
                            .opacity(curTab == tab.id ? 1 : 0)
                    }
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.white.opacity(1/4))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.vertical, 5)
                    .padding(.trailing, 5)
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            if let first = tabs.first {
                curTab = first.id
            }
        }
        .onTapGesture {
            showingCommandBar = false
        }
        .overlay {
            if showingCommandBar {
                ZStack {
                    Color.black.opacity(0.25)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showingCommandBar = false
                        }

                    CommandBarView(newUrl: $newUrl)
                        .clipShape(.rect(cornerRadius: 15))
                        .onSubmit {

                            var formatted: String

                            if newUrl.hasPrefix("http://") || newUrl.hasPrefix("https://") {
                                formatted = newUrl
                            } else if newUrl.contains(".") {
                                formatted = "https://" + newUrl
                            } else {
                                let query = newUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                formatted = "https://www.google.com/search?q=\(query)"
                            }

                            let newTab = Tab(url: formatted, webView: WebView(url: URL(string: formatted)!))

                            tabs.append(newTab)
                            curTab = newTab.id

                            newUrl = ""
                            showingCommandBar = false
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }.background {
            Button("") {
                showingCommandBar.toggle()
            }.opacity(0)
        }.keyboardShortcut("t", modifiers: .command)
    }
}

#Preview {
    ContentView()
}
