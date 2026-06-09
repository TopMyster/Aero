//
//  Tab.swift
//  Aero
//
//  Created by Toope Oladunjoye on 6/1/26.
//

import SwiftUI

struct Tab: Identifiable {
    var id = UUID()
    var url: String 
    var webView: WebView
    var container = WebViewContainer()
    
    init(id: UUID = UUID(), url: String, webView: WebView) {
        self.id = id
        self.url = url
        let container = WebViewContainer()
        self.webView = WebView(url: webView.url, container: container)
        self.container = container
    }
}

