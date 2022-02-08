//
//  NewsSourceEntity.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import Foundation

struct SourceResponse: Codable {
    var sources: [Source]
}

// MARK: - Source
struct Source: Codable {
    var id, name, description: String
    var url: String
    var category, language, country: String
}
