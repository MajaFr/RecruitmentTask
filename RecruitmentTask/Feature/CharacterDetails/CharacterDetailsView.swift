//
//  CharacterDetailsView.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import SwiftUI

struct CharacterDetailsView: View {
    let character: CharacterModel
    
    @StateObject private var episodeViewModel = EpisodeViewModel()
    @EnvironmentObject var appRouter: AppRouter
    
    var body: some View {
        ScrollView {
            BackButtonView(title: Constants.characterDetailsLabel) {
                appRouter.route(.characterView)
            }
            headerView
            Divider()
            episodeSection
            .font(.subheadline)
        }
        .padding()
        .task {
            episodeViewModel.setEpisodeUrls(character.episode)
            await episodeViewModel.getEpisodes()
        }
    }
    
    private var headerView: some View {
        VStack(spacing: .sizeMedium) {
            HStack {
                PersonImageView(imageURL: character.image, cornerRadius: .sizeMedium, size: .imageSizeDetails, placeholderIcon: Icons.person)
                Text(character.name)
                    .font(.title2.bold())
                Spacer()
            }
            Group {
                infoRow(title: Constants.statusLabel, value: character.status)
                infoRow(title: Constants.genderLabel, value: character.gender)
                infoRow(title: Constants.originLabel, value: character.origin.name)
                infoRow(title: Constants.locationLabel, value: character.location.name)
            }
        }
    }
    
    private var episodeSection: some View {
        VStack(alignment: .leading) {
            Text(Constants.episodesLabel)
                .font(.title2.bold())

            LazyVGrid(columns: [GridItem(.adaptive(minimum: .episodeWeight), spacing: .sizeMedium)], spacing: .sizeMedium) {
                ForEach(episodeViewModel.episodes) { episode in
                    Button {
                        appRouter.routeToEpisode(episode)
                    } label: {
                        Text(Constants.episodeLabel + "\n\(episode.episode)")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: .sizeXSmall)
                                .stroke()
                        )
                        .tint(.green)
                    }
                }
            }
            .padding(.horizontal, .sizeXSmall)
        }
    }
    
    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title + ": ")
                .foregroundColor(.secondary)
            Text(value)
            Spacer()
        }
        .font(.body)
    }
}

#Preview {
    PreviewRouterContainer(startingAt: .detailView)
}

private extension CharacterDetailsView {
    struct Constants {
        static let statusLabel = "Status"
        static let genderLabel = "Gender"
        static let originLabel = "Orgin"
        static let locationLabel = "Location"
        static let speciesLabel = "Species"
        static let episodeLabel = "Episode"
        static let episodesLabel = "Episodes"
        static let characterDetailsLabel = "Character Details"
    }
    
    struct Icons {
        static let person = "person.crop.square.fill"
        static let arrow = "arrow.backward.square.fill"
    }
}
