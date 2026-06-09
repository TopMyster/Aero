//
//  WebView.swift
//  Aero
//
//  Created by Toope Oladunjoye on 6/1/26.
//

import SwiftUI
import Combine
internal import WebKit

final class WebViewContainer: ObservableObject {
    @Published var webView: WKWebView?
}

struct WebView: NSViewRepresentable {
    
    let url: URL
    var container: WebViewContainer?
    
    func makeNSView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.customUserAgent =
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 15_0) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Safari/605.1.15"
        view.load(URLRequest(url: url))
        container?.webView = view
        return view
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        if nsView.url != url {
            nsView.load(URLRequest(url: url))
        }
    }
}
