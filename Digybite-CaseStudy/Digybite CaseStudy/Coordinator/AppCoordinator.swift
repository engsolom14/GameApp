//
//  AppCoordinator.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 01/06/2023.
//

import Foundation
import UIKit

final class AppCoordinator: PresentationCoordinator {
    var childCoordinators: [Coordinator] = []
    var rootViewController = AppRootTabbarViewController()

    init(window: UIWindow) {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    func start() {
    }
}
