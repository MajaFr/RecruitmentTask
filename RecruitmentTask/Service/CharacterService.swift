//
//  CharacterService.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import Foundation
import OSLog

protocol CharacterServiceProtocol {
    func getAllCharacters() async -> Result<[CharacterModel], Error>
    func performGetAllCharacters() async throws -> [CharacterModel]
}

class CharacterService: CharacterServiceProtocol {
    
    private let logger = Logger()
    private let httpsConnection: HttpsConnection = HttpsConnection()
    
    private lazy var decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func getAllCharacters() async -> Result<[CharacterModel], Error> {
        logger.debug(#function)
        
        do {
            let result = try await performGetAllCharacters()
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
    
    func performGetAllCharacters() async throws -> [CharacterModel] {
        logger.debug(#function)
        do {
            let data = try await httpsConnection.data(APIEndpoint.getCharacters)
            logger.info("Get characters successful")
            
            let response: CharactersResponse = try CharactersResponse.fromJsonData(data, decoder)
            return response.results
        } catch {
            logger.debug("Get characters failed: \(error)")
            throw error
        }
    }
}

final class MockCharacterService: CharacterServiceProtocol {
    func getAllCharacters() async -> Result<[CharacterModel], Error> {
        return .success([.mock, .mock])
    }

    func performGetAllCharacters() async throws -> [CharacterModel] {
        return [.mock, .mock]
    }
}
