//
//  NewsArticleRouter.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import Foundation

protocol NewsArticleRouterProtocol {
    init(viewController: NewsArticleViewController)
    func pushToDetail(article: Article)
}

class NewsArticleRouter: NewsArticleRouterProtocol {
    unowned let viewController: NewsArticleViewController
        
    required init(viewController: NewsArticleViewController) {
        self.viewController = viewController
    }
    
    func pushToDetail(article: Article) {
        let detailVC = DetailViewController()
        detailVC.article = article
        
        viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
}
