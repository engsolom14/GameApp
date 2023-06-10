//  GamesListPresenter.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 03/06/2023.
//

import Foundation

protocol GamesListView: AnyObject {
    func showLoader()
    func hideLoader()
    func showAPIErrorAlert(error: CustomError)
    func fetchDataSucessfull()
    func loadMoreSpinner()
    func loadmoreHideSpinner()
    func insertNewRows(at indexPaths: [IndexPath])
    
}

protocol GamesListCellView {
    func displayImage(image:String)
    func displayName(name:String)
    func displayGeners(name:String)
    func isOpened(isOpened:Bool)
    func configure(game: Game)
    func isFavShown(isFav:Bool)
}

protocol GamesListPresenter {
    func viewDidLoad()
    func loadMore()
    func refreshGamesList()
    func configure(cell: GamesListCellView, forRow row: Int)
    func numberOfRow() -> Int
    func saveGamesListToLocalStorage()
    func loadGamesListFromLocalStorage()
    func saveFavGame(for game: Game)
    func loadFavGames()
    func removeAllGames()
    func removeFavGames(for game: Game)
    func setSearchVal(_ searchVal: String)
    func selectedId(id: Int) -> Int
}

protocol GamesListInteractorToPresenterProtocol: AnyObject {
    func fetchedData( result: Result<GameModel ,CustomError> )
}

class GamesListPresenterImplementation: GamesListPresenter, GamesListInteractorToPresenterProtocol {
    
    fileprivate weak var view: GamesListView?
    internal let router: GamesListRouter
    internal let interactor : GamesListInteractorProtocol
    

    private var gamesList = [Game]()
    private var currentPage = 1
    private var totalPages = 0
    private var isfeatching:Bool = false
    private let dataManager: GamesListLocalDataManager
    
    var searchVal = ""
    var cellOpened = false
    
    init(view: GamesListView,router: GamesListRouter,interactor:GamesListInteractorProtocol,dataManager:GamesListLocalDataManager) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.dataManager = dataManager

        self.interactor.viewDidLoad(presenter: self)
    }
    
    func viewDidLoad() {
        self.view?.showLoader()
        self.interactor.fetchData(page: currentPage, searchQuery: searchVal)
    }
    
    func setSearchVal(_ searchVal: String) {
        self.searchVal = searchVal
        print("SSSEEAA:", searchVal)
    }
    func fetchedData(result: Result<GameModel ,CustomError>) {
        self.view?.hideLoader()
        switch result{
        case .success(let res):
            self.totalPages = res.count!
            if isfeatching {
                print("FROM LOAD MORE")
                let startIndex = self.gamesList.count
                self.gamesList.append(contentsOf: res.results)
                let endIndex = self.gamesList.count - 1
                let indexPaths = (startIndex...endIndex).map { IndexPath(row: $0, section: 0) }
                self.view?.insertNewRows(at: indexPaths)
                self.isfeatching = false
                self.view?.loadmoreHideSpinner()
            } else {
                print("FROM VIEW DID LOAD")
                self.gamesList = res.results
                self.currentPage = 1
                self.view?.fetchDataSucessfull()
            }
            saveGamesListToLocalStorage()
        case .failure(let error):
            self.view?.showAPIErrorAlert(error: error)
        }
    }
        
    func loadMore() {
        guard !isfeatching, currentPage < totalPages else { return }
        isfeatching = true
        currentPage += 1
        self.view?.loadMoreSpinner()
        self.interactor.fetchData(page: currentPage, searchQuery: searchVal)
    }
    
    func refreshGamesList() {
        currentPage = 1
        gamesList.removeAll()
        self.interactor.fetchData(page: currentPage, searchQuery: searchVal)
    }
    
    func configure(cell: GamesListCellView, forRow row: Int) {
        let game = self.gamesList[row]
        cell.configure(game: game)
        cell.displayName(name: game.name ?? "")
        cell.displayGeners(name: game.genres?.compactMap { $0.name }.joined(separator: ", ") ?? "")
        cell.displayImage(image: game.backgroundImageURL ?? "")
        cell.isFavShown(isFav: true)
        cell.isOpened(isOpened: cellOpened)
    }

    func numberOfRow() -> Int {
        return self.gamesList.count

    }

    func isfeatchingData() -> Bool {
        return self.isfeatching
    }

    //MARK: Locally Managed the data
    func saveGamesListToLocalStorage() {
        dataManager.saveGames(gamesList)
    }
        
    func loadGamesListFromLocalStorage() {
        if let savedGamesList = dataManager.loadGames() {
            gamesList = savedGamesList
            self.view?.fetchDataSucessfull()
        }
    }
    
    func saveFavGame(for game: Game) {
        dataManager.saveFavGames(game)
    }
    
    func loadFavGames() {
        if let savedGamesList = dataManager.loadFavGames() {
            gamesList = savedGamesList
            self.view?.fetchDataSucessfull()
        }
    }
    
    func removeFavGames(for game: Game) {
        _ = dataManager.removeFavGame(game)
    }
    
    func removeAllGames() {
        dataManager.removeAllGames()
    }
    
    func selectedId(id: Int) -> Int {
        let item = gamesList[id]
        return item.id ?? 1
    }
    
}
