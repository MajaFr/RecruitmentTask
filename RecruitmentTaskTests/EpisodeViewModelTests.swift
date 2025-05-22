//
//  EpisodeViewModelTests.swift
//  RecruitmentTaskTests
//
//  Created by Maja Frąk on 22/05/2025.
//

import XCTest
@testable import RecruitmentTask

@MainActor
final class EpisodeViewModelTests: XCTestCase {

    func test_getEpisodes_withURLs_setsEpisodes() async {
        let mockService = MockEpisodeService()
        let viewModel = EpisodeViewModel(service: mockService)
        viewModel.setEpisodeUrls(["https://rickandmortyapi.com/api/episode/1"])
        await viewModel.getEpisodes()
        XCTAssertEqual(viewModel.episodes.count, 2)
        XCTAssertEqual(viewModel.episodes.first?.id, 1)
    }

    func test_getEpisodes_emptyURLs_doesNothing() async {
        let mockService = MockEpisodeService()
        let viewModel = EpisodeViewModel(service: mockService)
        await viewModel.getEpisodes()
        XCTAssertTrue(viewModel.episodes.isEmpty)
    }
}
