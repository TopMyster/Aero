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
        return view
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        nsView.load(URLRequest(url: url))
    }
    
}
