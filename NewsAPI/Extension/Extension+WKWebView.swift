//
//  Extension+WKWebView.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 03/02/22.
//

import WebKit.WKWebView

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
