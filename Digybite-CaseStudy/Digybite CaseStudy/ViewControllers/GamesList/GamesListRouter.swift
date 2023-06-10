//
//  GamesListRouter.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 03/06/2023.
//

import UIKit


protocol GamesListRouter {
  
}

class GamesListRouterImplementation: GamesListRouter {
    fileprivate weak var GamesListViewController: GamesListViewController?
    
    init(GamesListViewController: GamesListViewController) {
        self.GamesListViewController = GamesListViewController
    }
    
    
}
