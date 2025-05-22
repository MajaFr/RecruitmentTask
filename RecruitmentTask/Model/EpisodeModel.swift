//
//  EpisodeModel.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import Foundation

struct EpisodeModel: Codable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters
        case airDate = "air_date"
    }
    
    var characterCount: Int {
        characters.count
    }
}

extension EpisodeModel {
    static var mock: EpisodeModel {
        EpisodeModel(id: 1, name: "Pilot", airDate: "December 2, 2013", episode: "S01E01", characters: ["https://rickandmortyapi.com/api/character/1", "https://rickandmortyapi.com/api/character/2"])
    }
}
