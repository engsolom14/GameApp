//
//  GameDetails.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 10/06/2023.
//

import Foundation

struct GameDetails: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let url: String?
    var isFavorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case description = "description_raw"
        case url = "metacritic_url"
    }

}
