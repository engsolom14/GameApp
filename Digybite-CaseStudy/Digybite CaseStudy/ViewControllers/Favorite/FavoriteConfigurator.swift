//
//  FavoriteConfigurator.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 10/06/2023.
//

import Foundation


protocol FavoriteConfigurator {
    func configure(FavoriteViewController:FavoriteViewController)
}


class FavoriteConfiguratorImplementation {

    func configure(FavoriteViewController:FavoriteViewController) {
        let view = FavoriteViewController
        let router = FavoriteRouterImplementation(FavoriteViewController: view)
        let interactor = FavoriteInteractor()
        let dataManager = GamesListUserDefaultsDataManager()

        let presenter = FavoritePresenterImplementation(view: view, router: router,interactor:interactor, dataManager: dataManager)
        
        
        FavoriteViewController.presenter = presenter
    }
    
}
