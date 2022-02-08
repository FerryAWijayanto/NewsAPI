//
//  NewsCatagoryBuilder.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import UIKit

protocol BuildModuleProtocol {
    static func build() -> UINavigationController
}

class NewsCatagoryBuilder: BuildModuleProtocol {
    static func build() -> UINavigationController {
        let viewController: NewsCatagoryViewController = NewsCatagoryViewController()
        let presenter = NewsCatagoryPresenter()
        let interactor = NewsCatagoryInteractor()
        let router = NewsCatagoryRouter(viewController: viewController)
        
        viewController.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewController
        
        interactor.presenter = presenter
        
        return UINavigationController(rootViewController: viewController)
    }
}
