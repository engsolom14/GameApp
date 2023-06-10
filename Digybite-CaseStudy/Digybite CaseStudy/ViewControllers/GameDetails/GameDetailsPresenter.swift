//
//  GameDetailsPresenter.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 10/06/2023.
//

import Foundation

protocol GameDetailsView: AnyObject {
    func fetchDataSucessfull()
    func showLoader()
    func hideLoader()
    func showAPIErrorAlert(error: CustomError)
    func updateData(game: GameDetails)
    func setTitle(isFav: Bool)
}


protocol GameDetailsPresenter {
    func viewDidLoad()
}

protocol GameDetailsInteractorToPresenterProtocol: AnyObject {
    func fetchedData(result: Result<GameDetails ,CustomError>)
}

class GameDetailsPresenterImplementation: GameDetailsPresenter, GameDetailsInteractorToPresenterProtocol {
    
    fileprivate weak var view: GameDetailsView?
    internal let router: GameDetailsRouter
    internal let interactor : GameDetailsInteractor
    
    var gameId = 0
    var isFav = false
    
    init(view: GameDetailsView,router: GameDetailsRouter,interactor:GameDetailsInteractor, id: Int, isFav: Bool) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.interactor.viewDidLoad(presenter: self)
        self.gameId = id
        self.isFav = isFav
    }


    func viewDidLoad() {
        self.view?.showLoader()
        self.view?.setTitle(isFav: isFav)
        self.interactor.fetchData(id: gameId)
    }
    
    func fetchedData(result: Result<GameDetails ,CustomError>) {
        self.view?.hideLoader()
        switch result{
        case .success(let res):
            self.view?.updateData(game: res)
            self.view?.fetchDataSucessfull()
        case .failure(let error):
            self.view?.showAPIErrorAlert(error: error)
        }
    }

}
