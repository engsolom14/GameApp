//
//  GamesListLocalDataManager.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 09/06/2023.
//

import Foundation

protocol GamesListLocalDataManager {
    func saveGames(_ games: [Game])
    func loadGames() -> [Game]?
    func saveFavGames(_ games: Game)
    func loadFavGames() -> [Game]?
    func removeFavGame(_ game: Game)-> Bool
    func removeAllGames()
}

class GamesListUserDefaultsDataManager: GamesListLocalDataManager {
    private let gamesListKey = "GamesList"
    private let favGamesListKey = "FAVGamesList"
    
    func saveGames(_ games: [Game]) {
        let gamesData = try? JSONEncoder().encode(games)
        UserDefaults.standard.set(gamesData, forKey: gamesListKey)
    }
    
    func saveFavGames(_ games: Game) {
        var favGames = loadFavGames()
        favGames?.append(games)
        let gamesData = try? JSONEncoder().encode(favGames)
        UserDefaults.standard.set(gamesData, forKey: favGamesListKey)

    }
    
    func loadGames() -> [Game]? {
        guard let gamesData = UserDefaults.standard.data(forKey: gamesListKey),
              let gamesList = try? JSONDecoder().decode([Game].self, from: gamesData) else {
            return nil
        }
        return gamesList
    }
    
    func loadFavGames() -> [Game]? {
        guard let gamesData = UserDefaults.standard.data(forKey: favGamesListKey) else {
            return []
        }
        let games = try? JSONDecoder().decode([Game].self, from: gamesData)
        return games ?? []
    }
    
    func removeFavGame(_ game: Game)-> Bool {
        var favGames = loadFavGames()
        if let index = favGames?.firstIndex(where: { $0.id == game.id }) {
            favGames?.remove(at: index)
            let gamesData = try? JSONEncoder().encode(favGames)
            UserDefaults.standard.set(gamesData, forKey: favGamesListKey)
            return true
        }
        return false
    }
    
    func removeAllGames() {
        UserDefaults.standard.removeObject(forKey: favGamesListKey)
    }

}
