import SwiftUI

struct ContentView: View {
    @State var searchText: String = ""
    @State var currWebsite: String = "https://google.com"

    var body: some View {
        HStack(spacing: 0) {
            // Sidebar
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                    TextField("Search", text: $searchText)
                        .onSubmit {
                            currWebsite = searchText
                        }
                }
                    .textFieldStyle(.plain)
                    .frame(width: 170, height: 30)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 6))
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(5)
                Spacer()
            }
            .frame(width: 200)
            .frame(maxHeight: .infinity, alignment: .topLeading)

            // Web
            WebView(url: URL(string: currWebsite)!)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white.opacity(1/4))
                .clipShape(.rect(cornerRadius: 10))
                .padding(.vertical, 5)
                .padding(.trailing, 5)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
