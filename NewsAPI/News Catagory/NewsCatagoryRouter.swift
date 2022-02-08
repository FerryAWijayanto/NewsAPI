//
//  NewsCatagoryRouter.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import Foundation

protocol NewsCatagoryRouterProtocol {
    init(viewController: NewsCatagoryViewController)
    func pushToDetail(catagory: CatagoryItem)
}

class NewsCatagoryRouter: NewsCatagoryRouterProtocol {
    unowned let viewController: NewsCatagoryViewController
        
    required init(viewController: NewsCatagoryViewController) {
        self.viewController = viewController
    }
    
    func pushToDetail(catagory: CatagoryItem) {
        let sourceVC = NewsSourceViewController()
        let presenter = NewsSourcePresenter()
        let interactor = NewsSourceInteractor()
        let router = NewsSourceRouter(viewController: sourceVC)
        
        sourceVC.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = sourceVC
        
        interactor.presenter = presenter
        sourceVC.item = catagory

        viewController.navigationController?.pushViewController(sourceVC, animated: true)
    }
}
