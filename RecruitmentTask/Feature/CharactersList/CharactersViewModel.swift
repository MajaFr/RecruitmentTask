//
//  CharactersViewModel.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import Foundation
import OSLog

@MainActor
class CharactersViewModel: ObservableObject {
    
    @Published var charterers: [CharacterModel] = []
    @Published var isShowingCharacters: Bool = false
    @Published private(set) var likedCharacters: Set<Int> = []
    private let logger = Logger()
    private let service: CharacterServiceProtocol
    
    init(service: CharacterServiceProtocol = CharacterService()) {
        self.service = service
    }
    
    func getCharacters() async {
        switch await service.getAllCharacters() {
        case let .success(model):
            self.charterers = model
        case let .failure(error):
            logger.log("Failed to fetch characters: \(error)")
        }
    }
}
