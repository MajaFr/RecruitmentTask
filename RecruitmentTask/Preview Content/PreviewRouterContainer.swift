//
//  PreviewRouterContainer.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import SwiftUI

struct PreviewRouterContainer: View {
    @StateObject private var mockRouter: AppRouter
    @StateObject private var mockCharactersViewModel: CharactersViewModel

    init(startingAt route: AppRouterCase = .characterView) {
        let router = AppRouter()
        router.selectedCharacter = CharacterModel.mock
        router.selectedEpisode = EpisodeModel.mock
        router.route(route)
        _mockRouter = StateObject(wrappedValue: router)
        _mockCharactersViewModel = StateObject(wrappedValue: CharactersViewModel(service: MockCharacterService()))
    }

    var body: some View {
        ZStack {
            switch mockRouter.router {
            case .characterView:
                CharactersView(viewModel: mockCharactersViewModel)
            case .detailView:
                if let selected = mockRouter.selectedCharacter {
                    CharacterDetailsView(character: selected)
                }
            case .episodeView:
                EpisodeView()
            }
        }
        .environmentObject(mockRouter)
    }
}

#Preview {
    PreviewRouterContainer()
}
