//
//  NewsSourceBuilder.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import UIKit

class NewsSourceBuilder: BuildModuleProtocol {
    static func build() -> UINavigationController {
        let viewController: NewsSourceViewController = NewsSourceViewController()
        let presenter = NewsSourcePresenter()
        let interactor = NewsSourceInteractor()
        let router = NewsSourceRouter(viewController: viewController)
        
        viewController.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewController
        
        interactor.presenter = presenter
        
        return UINavigationController(rootViewController: viewController)
    }
}
