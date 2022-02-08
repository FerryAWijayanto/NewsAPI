//
//  NewsCatagoryInteractor.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import Foundation

protocol NewsCatagoryInteractorProtocol: AnyObject {
    func fetch()
    func itemCount() -> Int
    func catagoryItem(at indexPath: IndexPath) -> CatagoryItem
    func pushToSource(at indexPath: IndexPath)
}

class NewsCatagoryInteractor: NewsCatagoryInteractorProtocol {
    
    fileprivate var items: [CatagoryItem] = []
    
    weak var presenter: NewsCatagoryPresenterOutput!
    
}

extension NewsCatagoryInteractor: DataManager {
    func fetch() {
        for data in load(file: "CatagoriesData") {
            items.append(CatagoryItem(dict: data))
        }
        presenter.presentCategory(item: items)
    }
    
    func itemCount() -> Int {
        return items.count
    }
    
    func catagoryItem(at indexPath: IndexPath) -> CatagoryItem {
        return items[indexPath.row]
    }
    
    func pushToSource(at indexPath: IndexPath) {
        let category = items[indexPath.row]
        presenter.presentToSource(category)
    }
}

extension NewsCatagoryInteractor {
//    private func newsCatagoryViewModel(from movieItem: Film) -> newsCatagoryViewModel.Cell {
//        return GhibliViewModel.Cell(imageName: movieItem.image, movieTitle: movieItem.title, releaseDate: movieItem.releaseDate, description: movieItem.description)
//    }
}
