import SwiftUI

struct ContentView: View {
    @State private var showingCommandBar = false
    @State private var newUrl = ""
    @State private var tabs: [Tab] = [Tab(url: "https://apple.com")]
    @State private var curTab: UUID = UUID()

    var currentIndex: Int? {
        tabs.firstIndex { $0.id == curTab }
    }

    var body: some View {
        ZStack(alignment: .center) {
            HStack(spacing: 0) {

                VStack(alignment: .leading) {

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

                                if let index = currentIndex {
                                    tabs[index].url = formatted
                                }
                            }
                    }
                    .textFieldStyle(.plain)
                    .frame(width: 170, height: 30)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 6))
                    .background(.ultraThinMaterial)
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

                if let index = currentIndex,
                   let url = URL(string: tabs[index].url) {

                    WebView(url: url)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.white.opacity(1/4))
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.vertical, 5)
                        .padding(.trailing, 5)
                        .ignoresSafeArea()

                } else {
                    Image(systemName: "globe")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
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

                            let newTab = Tab(url: formatted)

                            tabs.append(newTab)
                            curTab = newTab.id

                            newUrl = ""
                            showingCommandBar = false
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    ContentView()
}
