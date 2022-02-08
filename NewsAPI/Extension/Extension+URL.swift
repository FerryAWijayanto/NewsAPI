//
//  Extension+URL.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import Foundation

extension URL {
    static func makeForEndpoint(_ endpoint: String) -> URL {
        URL(string: "https://newsapi.org/v2/\(endpoint)")!
    }
}
