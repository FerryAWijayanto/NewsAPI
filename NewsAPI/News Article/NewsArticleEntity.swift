//
//  NewsArticleEntity.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import Foundation

struct ArticlesResponse: Codable {
    var articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    var source: ArticleSource
    var author: String?
    var title: String
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
}

// MARK: - Source
struct ArticleSource: Codable {
    var id: String?
    var name: String
}
