//
//  GameDetailsRouter.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 10/06/2023.
//

import UIKit


protocol GameDetailsRouter {
  
}

class GameDetailsRouterImplementation: GameDetailsRouter {
    fileprivate weak var GameDetailsViewController: GameDetailsViewController?
    
    init(GameDetailsViewController: GameDetailsViewController) {
        self.GameDetailsViewController = GameDetailsViewController
    }
    
    
}
