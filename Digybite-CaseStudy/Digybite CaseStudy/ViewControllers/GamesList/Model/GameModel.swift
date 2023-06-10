//
//  GameModel.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 03/06/2023.
//

import Foundation

struct GameModel: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Game]
}

//MARK: Game
struct Game: Codable {
    let id: Int?
    let name: String?
    let backgroundImageURL: String?
    let genres: [Genre]?
    var isFavorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, name, genres, isFavorite
        case backgroundImageURL = "background_image"
    }
}

//MARK: Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}
