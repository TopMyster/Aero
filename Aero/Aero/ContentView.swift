import SwiftUI

struct ContentView: View {
    @State private var showingCommandBar = false
    @State private var newUrl = ""
    @State private var tabs: [Tab] = {
        let tab = Tab(url: "https://apple.com")
        return [tab]
    }()
    @State private var curTab = Tab(url: "https://apple.com")
    
    var body: some View {
        ZStack(alignment: .center) {
            HStack(spacing: 0) {
                // Sidebar
                VStack(alignment: .leading) {
                    //Navigation
    
                    //Searchbar
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
                                curTab.url = formatted
                            }
                    }
                    .textFieldStyle(.plain)
                    .frame(width: 170, height: 30)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 6))
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(5)
                    //Tabs
                    ScrollView {
                        TabsView(tabs: $tabs, curTab: $curTab, showingCommandBar: $showingCommandBar)
                    }
                    Spacer()
                    
                }
                .frame(width: 200)
                .frame(maxHeight: .infinity, alignment: .topLeading)
                
                // Web
                if let url = URL(string: curTab.url) {
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
        }.onTapGesture {
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
                            curTab = newTab
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
