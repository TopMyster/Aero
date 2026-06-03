import SwiftUI
import AppKit

struct ContentView: View {
    @State private var showingCommandBar = false
    @State private var newUrl = ""
    @State private var tabs: [Tab] = []
    @State private var curTab: UUID = UUID()
    @State private var showAI: Bool = false

    var currentIndex: Int? {
        tabs.firstIndex { $0.id == curTab }
    }

    var body: some View {
        ZStack(alignment: .center) {
            HStack(spacing: 0) {

                VStack(alignment: .center) {
                    HStack(spacing: 12) {
                        Button(action: {
                            withAnimation {
                                showAI.toggle()
                            }
                        }, label: {
                            Image(systemName: "sparkle")
                        })
                        .buttonStyle(.plain)
                        
                        Button(action: {

                        }, label: {
                            Image(systemName: "arrow.backward")
                        })
                        .buttonStyle(.plain)
                        
                        Button(action: {

                        }, label: {
                            Image(systemName: "arrow.forward")
                        })
                        .buttonStyle(.plain)
                        
                        Button(action: {

                        }, label: {
                            Image(systemName: "arrow.clockwise")
                        })
                        .buttonStyle(.plain)
                        
                    }
                    .padding(.leading, 65)
                    .font(.custom("btn", size: 15))
                    .padding(.top, 12)
                    .padding(.bottom, 3)
                    
                    
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
                                    withAnimation {
                                        tabs[index].url = formatted
                                    }
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
                .ignoresSafeArea()
                .frame(maxHeight: .infinity, alignment: .topLeading)
                ZStack {
                    ForEach(tabs) { tab in
                        HStack(spacing: 2) {
                            tab.webView
                                .transition(.blurReplace)
                                .opacity(curTab == tab.id ? 1 : 0)
                                .clipShape(.rect(cornerRadius: 10))
                            if showAI {
                                WebView(url: URL(string: "https://chatgpt.com")!)
                                    .frame(width: 350)
                                    .clipShape(.rect(cornerRadius: 10))
                                
                            }
                        }
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
                withAnimation {
                    curTab = first.id
                }
            }
            if let window = NSApp.windows.first {
                window.standardWindowButton(.closeButton)?.setFrameOrigin(NSPoint(x: 15, y: 3.5))
                window.standardWindowButton(.miniaturizeButton)?.setFrameOrigin(NSPoint(x: 35, y: 3.5))
                window.standardWindowButton(.zoomButton)?.setFrameOrigin(NSPoint(x: 55, y: 3.5))
            }
        }
        .onTapGesture {
            withAnimation {
                showingCommandBar = false
            }
        }
        .overlay {
            if showingCommandBar {
                ZStack {
                    Color.black.opacity(0.25)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                showingCommandBar = false
                            }
                        }

                    CommandBarView(newUrl: $newUrl)
                        .transition(.move(edge: .bottom))
                        .padding(.bottom, 15)
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

                            withAnimation {
                                tabs.append(newTab)
                                curTab = newTab.id
                            }

                            newUrl = ""
                            withAnimation {
                                showingCommandBar = false
                            }
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background {
            Button("") {
                withAnimation {
                    showingCommandBar.toggle()
                }
            }
            .opacity(0)
        }
        .keyboardShortcut("t", modifiers: .command)
    }
}

#Preview {
    ContentView()
}
