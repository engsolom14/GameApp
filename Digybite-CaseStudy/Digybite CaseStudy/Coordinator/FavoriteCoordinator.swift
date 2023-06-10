//
//  FavoriteCoordinator.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 01/06/2023.
//

import UIKit

class FavoriteCoordinator: NavigationCoordinator {
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    
    private let FavoriteViewController: FavoriteViewController
    
    init() {
        FavoriteViewController = Digybite_CaseStudy.FavoriteViewController()
        let navigationController = UINavigationController(rootViewController: FavoriteViewController)
        
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        FavoriteViewController.delegate = self
    }
}

extension FavoriteCoordinator: FavDelegate {
}
