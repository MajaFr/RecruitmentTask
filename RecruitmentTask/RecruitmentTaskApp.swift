//
//  RecruitmentTaskApp.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import SwiftUI

@main
struct RecruitmentTaskApp: App {
    
    @StateObject private var appRouter = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch appRouter.router {
                case .characterView:
                    CharactersView(viewModel: appRouter.charactersViewModel)
                case .detailView:
                    if let selected = appRouter.selectedCharacter {
                        CharacterDetailsView(character: selected)
                    }
                case .episodeView:
                    EpisodeView()
                }
            }
            .environmentObject(appRouter)
        }
    }
}
