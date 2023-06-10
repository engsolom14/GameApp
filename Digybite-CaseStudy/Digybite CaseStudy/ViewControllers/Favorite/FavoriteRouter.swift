//
//  FavoriteRouter.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 10/06/2023.
//

import UIKit


protocol FavoriteRouter {
  
}

class FavoriteRouterImplementation: FavoriteRouter {
    fileprivate weak var FavoriteViewController: FavoriteViewController?
    
    init(FavoriteViewController: FavoriteViewController) {
        self.FavoriteViewController = FavoriteViewController
    }
    
    
}
