//
//  EpisodeViewModel.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import Foundation

import Foundation
import OSLog

@MainActor
class EpisodeViewModel: ObservableObject {
    
    @Published var episodes: [EpisodeModel] = []
    private let logger = Logger()
    private let service: EpisodeServiceProtocol
    private var episodeUrls: [String] = []
    
    init(service: EpisodeServiceProtocol = EpisodeService()) {
        self.service = service
    }
    
    func setEpisodeUrls(_ urls: [String]) {
        self.episodeUrls = urls
    }
    
    func getEpisodes() async {
        guard !episodeUrls.isEmpty else {
            logger.debug("No episode URLs to load.")
            return
        }
        switch await service.getEpisodes(from: episodeUrls) {
        case .success(let result):
            self.episodes = result
        case .failure(let error):
            logger.error("Failed to fetch episodes: \(error.localizedDescription)")
        }
    }
}
