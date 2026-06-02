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
    
    init(id: UUID = UUID(), url: String, webView: WebView) {
        self.id = id
        self.url = url
        self.webView = webView
    }
}

