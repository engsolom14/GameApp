//
//  FavoritePresenter.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 10/06/2023.
//

import Foundation

protocol FavoriteView: AnyObject {
    func noData()
    func loadDataSucessfull()
}

protocol FavoritePresenter {
    func viewDidLoad()
    func configure(cell: GamesListCellView, forRow row: Int)
    func numberOfRow() -> Int
    func delete(index: Int)
}

class FavoritePresenterImplementation: FavoritePresenter {
    fileprivate weak var view: FavoriteView?
    internal let router: FavoriteRouter
    internal let interactor : FavoriteInteractor
    private let dataManager: GamesListLocalDataManager

    private var gamesList = [Game]()
    
    init(view: FavoriteView,router: FavoriteRouter,interactor:FavoriteInteractor, dataManager: GamesListLocalDataManager) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.dataManager = dataManager
    }

    
    func viewDidLoad() {
        if let savedGamesList = dataManager.loadFavGames() {
            if savedGamesList.count == 0 {
                self.view?.noData()
            } else {
                gamesList = savedGamesList
                self.view?.loadDataSucessfull()
            }
        }
    }
    
    func configure(cell: GamesListCellView, forRow row: Int) {
        let game = self.gamesList[row]
        cell.configure(game: game)
        cell.displayName(name: game.name ?? "")
        cell.displayGeners(name: game.genres?.compactMap { $0.name }.joined(separator: ", ") ?? "")
        cell.displayImage(image: game.backgroundImageURL ?? "")
        cell.isFavShown(isFav: false)
    }

    func numberOfRow() -> Int {
        return self.gamesList.count
    }
    
    func delete(index: Int) {
        let item = gamesList[index]
        if dataManager.removeFavGame(item) {
            gamesList.remove(at: index)
            self.viewDidLoad()
        }
    }

}
