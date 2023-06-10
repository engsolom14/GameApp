//
//  GameDetailsConfigurator.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 10/06/2023.
//

import Foundation


protocol GameDetailsConfigurator {
    func configure(GameDetailsViewController:GameDetailsViewController)
}


class GameDetailsConfiguratorImplementation {

    func configure(GameDetailsViewController:GameDetailsViewController, gameId: Int, isFav: Bool) {
        let view = GameDetailsViewController
        let router = GameDetailsRouterImplementation(GameDetailsViewController: view)
        
        let interactor = GameDetailsInteractor()
        let presenter = GameDetailsPresenterImplementation(view: view, router: router,interactor:interactor, id: gameId, isFav: isFav)
        
        
        GameDetailsViewController.presenter = presenter
    }
    
}
