//
//  WebView.swift
//  Aero
//
//  Created by Toope Oladunjoye on 6/1/26.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    
    let url: URL
    
    func makeNSView(context: Context) -> some WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: url))
        view.customUserAgent =
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 15_0) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Safari/605.1.15"
        return view
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        if let currview = nsView.url,
           currview != url {
            nsView.load(URLRequest(url: url))
        } else {
            nsView.load(URLRequest(url: url))
        }
    }
}
