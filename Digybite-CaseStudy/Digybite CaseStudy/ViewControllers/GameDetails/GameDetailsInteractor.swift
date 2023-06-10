//
//  GameDetailsInteractor.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 10/06/2023.
//

import Foundation

 protocol GameDetailsInteractorProtocol {
     func viewDidLoad(presenter:GameDetailsInteractorToPresenterProtocol?)
     func fetchData(id: Int)
 }

class GameDetailsInteractor: GameDetailsInteractorProtocol {
     fileprivate weak var presenter:GameDetailsInteractorToPresenterProtocol?
     func viewDidLoad(presenter: GameDetailsInteractorToPresenterProtocol?) {
         self.presenter = presenter
     }
     
    func fetchData(id: Int) {
        let params: [String:Any] = ["key": APIConstants.apiKey]
         APIClient().executeQuery(params: params, mapTo: APIRouter.gamelistDetails(id: id)) { [weak self](result: Result<GameDetails ,CustomError>) in
             guard let self = self else { return  }
             self.presenter?.fetchedData(result: result)
         }

     }

 }
