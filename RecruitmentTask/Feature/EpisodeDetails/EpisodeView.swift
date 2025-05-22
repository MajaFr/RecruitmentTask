//
//  EpisodeView.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import SwiftUI

struct EpisodeView: View {
    @EnvironmentObject var appRouter: AppRouter

    var body: some View {
        if let episode = appRouter.selectedEpisode {
            VStack(spacing: .sizeMedium) {
                BackButtonView(title: Constants.episodeDetailLabel) {
                    appRouter.route(.detailView)
                }
                Text(episode.name)
                    .font(.title.bold())
                infoRow(title: Constants.airDateLabel, value: episode.airDate, icon: Icons.calendar)
                infoRow(title: Constants.episodeCodeLabel, value: episode.episode, icon: Icons.tag)
                infoRow(title: Constants.numberOfcharactersLabel, value: "\(episode.characterCount)", icon: Icons.persons)
                Spacer()
            }
            .padding()
        } else {
            Text(Constants.noEpisodesLabel)
                .foregroundColor(.gray)
        }
    }
    
    private func infoRow(title: String, value: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .frame(width: .sizeMedium)
            Text("\(title): ")
                .foregroundColor(.secondary)
            Text(value)
            Spacer()
        }
        .font(.body)
    }
}

#Preview {
    PreviewRouterContainer(startingAt: .episodeView)
}

private extension EpisodeView {
    struct Constants {
        static let airDateLabel = "Air Date"
        static let episodeCodeLabel = "Episode Code"
        static let numberOfcharactersLabel = "Number of Characters"
        static let episodeDetailLabel = "Episode Details"
        static let noEpisodesLabel = "No episodes selected"
    }

    struct Icons {
        static let arrow = "arrow.backward.square.fill"
        static let calendar = "calendar"
        static let tag = "number"
        static let persons = "person.2.fill"
    }
}
