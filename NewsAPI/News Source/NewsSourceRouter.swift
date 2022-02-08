//
//  NewsSourceRouter.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import Foundation

protocol NewsSourceRouterProtocol {
    init(viewController: NewsSourceViewController)
    func pushToDetail(source: Source)
}

class NewsSourceRouter: NewsSourceRouterProtocol {
    unowned let viewController: NewsSourceViewController
        
    required init(viewController: NewsSourceViewController) {
        self.viewController = viewController
    }
    
    func pushToDetail(source: Source) {
        let vc = NewsArticleViewController()
        let presenter = NewsArticlePresenter()
        let interactor = NewsArticleInteractor()
        let router = NewsArticleRouter(viewController: vc)
        
        vc.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = vc
        
        interactor.presenter = presenter
        
        vc.source = source
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
