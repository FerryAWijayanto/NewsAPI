//
//  NewsArticlePresenter.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import Foundation

protocol NewsArticlePresenterInput: AnyObject {
    func fetchArticle(with source: String, page: Int)
    func allArticles()
    func count() -> Int
    func filterCount() -> Int
    func cellForRow(at indexPath: IndexPath) -> Article
    func filterCellForRowAt(at indexPath: IndexPath) -> Article
    func didSelectRowAt(_ indexPath: IndexPath)
    func searchArticle(with search: String)
    func hasMoreArticle() -> Bool
    func articleFilterRemoveAll()
    func showLoading()
}

protocol NewsArticlePresenterOutput: AnyObject {
    func present(articles: [Article])
    func presentFilterArticle(_ articles: [Article])
    func present(error: String)
    func present(article: Article)
    func reloadArticles()
    func displayLoading()
}

class NewsArticlePresenter: NewsArticlePresenterInput {
    weak var view: NewsArticleViewProtocol!
    var interactor: NewsArticleInteractorProtocol!
    var router: NewsArticleRouterProtocol!
    
    func fetchArticle(with source: String, page: Int) {
        interactor.fetchArticle(with: source, page: page)
    }
    
    func allArticles() {
        interactor.allArticles()
    }
    
    func count() -> Int {
        interactor.numberOfRowsInSection()
    }
    
    func filterCount() -> Int {
        interactor.filterNumberOfItems()
    }
    
    func cellForRow(at indexPath: IndexPath) -> Article {
        interactor.cellForRow(at: indexPath)
    }
    
    func filterCellForRowAt(at indexPath: IndexPath) -> Article {
        interactor.filterCellForRowAt(at: indexPath)
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        interactor.didSelectRow(at: indexPath)
    }
    
    func searchArticle(with search: String) {
        interactor.searchArticle(with: search)
    }
    
    func hasMoreArticle() -> Bool {
        interactor.isMoreArticle()
    }
    
    func articleFilterRemoveAll() {
        interactor.articleFilterRemoveAll()
    }
    
    func showLoading() {
        interactor.showLoading()
    }
}

extension NewsArticlePresenter: NewsArticlePresenterOutput {
    func present(articles: [Article]) {
        view.reloadArticle()
    }
    
    func reloadArticles() {
        view.reloadArticle()
    }
    
    func presentFilterArticle(_ articles: [Article]) {
        view.reloadArticle()
    }
    
    func present(error: String) {
        view.showError(error)
    }
    
    func present(article: Article) {
        router.pushToDetail(article: article)
    }
    
    func displayLoading() {
        view.loadingIndicator()
    }
}
