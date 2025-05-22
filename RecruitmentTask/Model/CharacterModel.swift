//
//  CharacterModel.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import Foundation

struct CharactersResponse: Codable {
    let results: [CharacterModel]
}

struct CharacterModel: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterOriginModel
    let location: CharacterLocationModel
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct CharacterOriginModel: Codable {
    let name: String
    let url: String
}

struct CharacterLocationModel: Codable {
    let name: String
    let url: String
}

extension CharacterModel {
    static var mock: CharacterModel {
        CharacterModel(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: CharacterOriginModel(name: "Earth", url: ""),
            location: CharacterLocationModel(name: "Citadel of Ricks", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: ["https://rickandmortyapi.com/api/episode/51"],
            url: "",
            created: ""
        )
    }
}
