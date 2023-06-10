//
//  GamesListInteractor.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 03/06/2023.
//

import Foundation

protocol GamesListInteractorProtocol{
    func viewDidLoad(presenter:GamesListInteractorToPresenterProtocol?)
    func fetchData(page: Int, searchQuery: String)
}

class GamesListInteractor: GamesListInteractorProtocol {
     fileprivate weak var presenter:GamesListInteractorToPresenterProtocol?
     func viewDidLoad(presenter: GamesListInteractorToPresenterProtocol?) {
         self.presenter = presenter
     }
     
    func fetchData(page: Int, searchQuery: String) {
        let params: [String:Any] = ["key": APIConstants.apiKey, "page": page , "page_size": 10, "search": searchQuery]
         APIClient().executeQuery(params: params, mapTo: APIRouter.gamesList) { [weak self](result: Result<GameModel ,CustomError>) in
             guard let self = self else { return  }
             self.presenter?.fetchedData(result: result)
             //print("RESSS:", result.self)
         }
         
     }

 }
