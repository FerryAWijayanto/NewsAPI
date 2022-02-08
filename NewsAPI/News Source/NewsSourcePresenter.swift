//
//  NewsSourcePresenter.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import Foundation

protocol NewsSourcePresenterInput: AnyObject {
    func fetch(source: String, page: Int)
    func allSources()
    func count() -> Int
    func filterCount() -> Int
    func cellForRowAt(at indexPath: IndexPath) -> Source
    func filterCellForRowAt(at indexPath: IndexPath) -> Source
    func pushToArticle(at indexPath: IndexPath)
    func searchSource(with search: String)
    func hasMoreSource() -> Bool
    func sourceFilterRemoveAll()
    func showLoading()
}

protocol NewsSourcePresenterOutput: AnyObject {
    func presentSource(_ source: [Source])
    func presentFilterSource(_ source: [Source])
    func presentError(_ error: String)
    func presentToArticle(article: Source)
    func reloadSource()
    func displayLoading()
}

class NewsSourcePresenter: NewsSourcePresenterInput {
    weak var view: NewsSourceViewProtocol!
    var interactor: NewsSourceInteractorProtocol!
    var router: NewsSourceRouterProtocol!
    
    func fetch(source: String, page: Int) {
        interactor.fetch(with: source, page: page)
    }
    
    func allSources() {
        interactor.allSources()
    }
    
    func count() -> Int {
        interactor.numberOfItems()
    }
    
    func filterCount() -> Int {
        return interactor.filterNumberOfItems()
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Source {
        interactor.cellForRow(at: indexPath)
    }
    
    func filterCellForRowAt(at indexPath: IndexPath) -> Source {
        interactor.filterCellForRowAt(at: indexPath)
    }
    
    func pushToArticle(at indexPath: IndexPath) {
        interactor.pushToArticle(at: indexPath)
    }
    
    func searchSource(with search: String) {
        interactor.searchSource(with: search)
    }
    
    func hasMoreSource() -> Bool {
        interactor.ifMoreSource()
    }
    
    func sourceFilterRemoveAll() {
        interactor.sourceFilterRemoveAll()
    }
    
    func showLoading() {
        interactor.showLoading()
    }
}

extension NewsSourcePresenter: NewsSourcePresenterOutput {
    func presentSource(_ source: [Source]) {
        view.reloadSource()
    }
    
    func reloadSource() {
        view.reloadSource()
    }
    
    func presentFilterSource(_ source: [Source]) {
        view.reloadSource()
    }
    
    func presentError(_ error: String) {
        view.displayError(error: error)
    }
    
    func presentToArticle(article: Source) {
        router.pushToDetail(source: article)
    }
    
    func displayLoading() {
        view.loadingIndicator()
    }
}
