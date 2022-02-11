//
//  NewsArticleInteractor.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import Foundation

protocol NewsArticleInteractorProtocol: AnyObject {
    func fetchArticle(with source: String, page: Int)
    func allArticles()
    func numberOfRowsInSection() -> Int
    func filterNumberOfItems() -> Int
    func cellForRow(at indexPath: IndexPath) -> Article
    func filterCellForRowAt(at indexPath: IndexPath) -> Article
    func didSelectRow(at indexPath: IndexPath)
    func searchArticle(with search: String)
    func isMoreArticle() -> Bool
    func articleFilterRemoveAll()
    func showLoading()
}

class NewsArticleInteractor: NewsArticleInteractorProtocol {
    
    weak var presenter: NewsArticlePresenterOutput!
    
    var hasMoreArticle = true
    
    private var articles: [Article] = []
    private var filterArticles: [Article] = []
    
    private let service = NetworkDataFetcher(service: NetworkService())
    
    func fetchArticle(with source: String, page: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.service.getArticle(endpoint: .getArticleSource(source, page)) { [weak self] results in
                guard let self = self else { return }
                switch results {
                case .success(let articles):
                    self.articles.append(contentsOf: articles)
                    if articles.count < 20 { self.hasMoreArticle = false }
                    self.presenter.present(articles: articles)
                case .failure(let error):
                    self.presenter.present(error: error.errorDescription)
                }
            }
        }
    }
    
    func allArticles() {
        articles = filterArticles
        presenter.reloadArticles()
    }
    
    func numberOfRowsInSection() -> Int {
        return articles.count
    }
    
    func filterNumberOfItems() -> Int {
        return filterArticles.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> Article {
        return articles[indexPath.row]
    }
    
    func filterCellForRowAt(at indexPath: IndexPath) -> Article {
        return filterArticles[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let article = articles[indexPath.row]
        presenter.present(article: article)
    }
    
    func searchArticle(with search: String) {
        filterArticles = articles.filter { $0.title.contains(search) }
        presenter.presentFilterArticle(filterArticles)
    }
    
    func isMoreArticle() -> Bool {
        return hasMoreArticle
    }
    
    func articleFilterRemoveAll() {
        filterArticles.removeAll()
    }
    
    func showLoading() {
        presenter.displayLoading()
    }
}
