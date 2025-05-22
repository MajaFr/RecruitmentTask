//
//  AppRouter.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import SwiftUI

enum AppRouterCase {
    case characterView
    case detailView
    case episodeView
}

@MainActor
class AppRouter: ObservableObject {
    @Published private(set) var router: AppRouterCase = .characterView
    @Published var selectedCharacter: CharacterModel?
    @Published var selectedEpisode: EpisodeModel?
    @Published var charactersViewModel = CharactersViewModel()
    
    func route(_ to: AppRouterCase) {
        withAnimation { router = to }
    }
    
    func routeToCharacter(_ character: CharacterModel) {
        selectedCharacter = character
        route(.detailView)
    }
    
    func routeToEpisode(_ episode: EpisodeModel) {
        selectedEpisode = episode
        route(.episodeView)
    }
}

final class MockedRouter: AppRouter {
    override init() {
        super.init()
        self.selectedCharacter = CharacterModel.mock
        self.selectedEpisode = EpisodeModel.mock
        self.route(.detailView)
    }
}
