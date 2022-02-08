//
//  NewsCatagoryPresenter.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import Foundation

protocol NewsCatagoryPresenterInput: AnyObject {
    func fetchCategory()
    func count() -> Int
    func category(at indexPath: IndexPath) -> CatagoryItem
    func pushToSource(at indexPath: IndexPath)
}

protocol NewsCatagoryPresenterOutput: AnyObject {
    func presentCategory(item: [CatagoryItem])
    func presentToSource(_ category: CatagoryItem)
}

class NewsCatagoryPresenter: NewsCatagoryPresenterInput {
    weak var view: NewsCatagoryViewProtocol!
    var interactor: NewsCatagoryInteractorProtocol!
    var router: NewsCatagoryRouterProtocol!
    
    func fetchCategory() {
        interactor.fetch()
    }
    
    func count() -> Int {
        interactor.itemCount()
    }
    
    func category(at indexPath: IndexPath) -> CatagoryItem {
        interactor.catagoryItem(at: indexPath)
    }
    
    func pushToSource(at indexPath: IndexPath) {
        interactor.pushToSource(at: indexPath)
    }
}

extension NewsCatagoryPresenter: NewsCatagoryPresenterOutput {
    func presentCategory(item: [CatagoryItem]) {
        view.showCategory()
    }
    
    func presentToSource(_ category: CatagoryItem) {
        router.pushToDetail(catagory: category)
    }
}
