//
//  Endpoint.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import Foundation

enum Endpoint {
    case getCategory(String, Int)
    case getArticleSource(String, Int)
    
    var apiKey: String {
        return "76fa09707c5f4efbb7ad898dda51465b"
    }
    
    var url: URL {
        switch self {
        case .getCategory(let category, let page):
            return .makeForEndpoint("top-headlines/sources?category=\(category)&page=\(page)&apiKey=\(apiKey)")
        case .getArticleSource(let source, let page):
            return .makeForEndpoint("top-headlines?sources=\(source)&page=\(page)&apiKey=\(apiKey)")
        }
    }
}
