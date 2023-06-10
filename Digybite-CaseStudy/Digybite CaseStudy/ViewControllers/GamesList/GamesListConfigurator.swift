//
//  GamesListConfigurator.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 03/06/2023.
//

import Foundation


protocol GamesListConfigurator {
    func configure(GamesListViewController:GamesListViewController)
}


class GamesListConfiguratorImplementation {

    func configure(GamesListViewController:GamesListViewController) {
        let view = GamesListViewController
        let router = GamesListRouterImplementation(GamesListViewController: view)
        let interactor = GamesListInteractor()
        let dataManager = GamesListUserDefaultsDataManager()

        let presenter = GamesListPresenterImplementation(view: view, router: router,interactor:interactor, dataManager: dataManager)

        GamesListViewController.presenter = presenter
    }
    
}
