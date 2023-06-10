//
//  GameListCoordinator.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 01/06/2023.
//

import UIKit

class GamesListCoordinator: NavigationCoordinator {
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    
    private let GameListViewController: GamesListViewController
    
    init() {
        GameListViewController = GamesListViewController()
        let navigationController = UINavigationController(rootViewController: GameListViewController)
        
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        GameListViewController.delegate = self
    }
}

extension GamesListCoordinator: GameListDelegate {
    func didSelectGame(id: Int, isFav: Bool) {
        let gameDetailsVC = GameDetailsViewController()
//        gameDetailsVC.delegate = self
        let configurator = GameDetailsConfiguratorImplementation()
        configurator.configure(GameDetailsViewController: gameDetailsVC, gameId: id, isFav: isFav)
        navigator.push(gameDetailsVC, animated: true)

    }
    
    
}
