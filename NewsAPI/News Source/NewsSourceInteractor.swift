//
//  NewsSourceInteractor.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import Foundation

protocol NewsSourceInteractorProtocol: AnyObject {
    func fetch(with category: String, page: Int)
    func allSources()
    func numberOfItems() -> Int
    func filterNumberOfItems() -> Int
    func cellForRow(at indexPath: IndexPath) -> Source
    func filterCellForRowAt(at indexPath: IndexPath) -> Source
    func pushToArticle(at indexPath: IndexPath)
    func searchSource(with search: String)
    func ifMoreSource() -> Bool
    func sourceFilterRemoveAll()
    func showLoading()
}

class NewsSourceInteractor: NewsSourceInteractorProtocol {
    private var sources: [Source] = []
    private var filterSource: [Source] = []
    
    var hasMoreSource = true
    
    weak var presenter: NewsSourcePresenterOutput!
    
    private let service = NetworkDataFetcher(service: NetworkService())
    
    func fetch(with category: String, page: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.service.getSource(endpoint: .getCategory(category, page)) { [weak self] results in
                guard let self = self else { return }
                switch results {
                case .success(let sources):
                    self.sources = sources
                    if sources.count < 20 { self.hasMoreSource = false }
                    self.presenter.presentSource(sources)
                case .failure(let error):
                    self.presenter.presentError(error.errorDescription)
                }
            }
        }
    }
    
    func allSources() {
        sources = filterSource
        presenter.reloadSource()
    }
    
    func numberOfItems() -> Int {
        return sources.count
    }
    
    func filterNumberOfItems() -> Int {
        return filterSource.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> Source {
        return sources[indexPath.row]
    }
    
    func filterCellForRowAt(at indexPath: IndexPath) -> Source {
        return filterSource[indexPath.row]
    }
    
    func pushToArticle(at indexPath: IndexPath) {
        let article = sources[indexPath.row]
        presenter.presentToArticle(article: article)
    }
    
    func searchSource(with search: String) {
        filterSource = sources.filter { $0.name.contains(search) }
        presenter.presentFilterSource(filterSource)
    }
    
    func ifMoreSource() -> Bool {
        return hasMoreSource
    }
    
    func sourceFilterRemoveAll() {
        filterSource.removeAll()
    }
    
    func showLoading() {
        presenter.displayLoading()
    }
}
