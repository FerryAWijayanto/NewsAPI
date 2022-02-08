//
//  NewsArticleBuilder.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import UIKit

class NewsArticleBuilder: BuildModuleProtocol {
    static func build() -> UINavigationController {
        let viewController: NewsArticleViewController = NewsArticleViewController()
        let presenter = NewsArticlePresenter()
        let interactor = NewsArticleInteractor()
        let router = NewsArticleRouter(viewController: viewController)
        
        viewController.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewController
        
        interactor.presenter = presenter
        
        return UINavigationController(rootViewController: viewController)
    }
}
