//
//  NewsCatagoryEntity.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import Foundation

struct CatagoryItem {
    let name: String?
    let image: String?
    let color: String?
}

extension CatagoryItem {
    init(dict: [String: AnyObject]) {
        self.name = dict["category"] as? String
        self.image = dict["image"] as? String
        self.color = dict["color"] as? String
    }
}
