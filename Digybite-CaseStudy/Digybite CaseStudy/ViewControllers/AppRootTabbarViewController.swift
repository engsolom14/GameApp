//
//  AppRootTabbarViewController.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 01/06/2023.
//

import UIKit

class AppRootTabbarViewController: UITabBarController {
    private let gameListCoordinator = GamesListCoordinator()
    private let favoriteCoordinator = FavoriteCoordinator()
    
    private var gameListVC: UIViewController {
        return self.gameListCoordinator.rootViewController
    }

    private var favVC: UIViewController {
        return self.favoriteCoordinator.rootViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        favVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        
        gameListCoordinator.start()
        favoriteCoordinator.start()
        
        self.viewControllers = [gameListVC, favVC]
    }
    
}
