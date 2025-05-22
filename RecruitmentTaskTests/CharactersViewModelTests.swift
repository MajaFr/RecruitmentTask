//
//  CharactersViewModelTests.swift
//  RecruitmentTaskTests
//
//  Created by Maja Frąk on 22/05/2025.
//

import XCTest
@testable import RecruitmentTask

@MainActor
final class CharactersViewModelTests: XCTestCase {
    
    func test_getCharacters_success_setsCharactersAndShowsList() async {
        let mockService = MockCharacterService()
        let viewModel = CharactersViewModel(service: mockService)
        await viewModel.getCharacters()
        XCTAssertEqual(viewModel.characters.count, 2)
        XCTAssertFalse(viewModel.characters.isEmpty)
    }
}
