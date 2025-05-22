//
//  EpisodeService.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import Foundation
import OSLog

protocol EpisodeServiceProtocol {
    func getEpisodes(from urls: [String]) async -> Result<[EpisodeModel], Error>
}

class EpisodeService: EpisodeServiceProtocol {
    
    private let logger = Logger()
    private let httpsConnection: HttpsConnection = HttpsConnection()
    
    private lazy var decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func getEpisodes(from urls: [String]) async -> Result<[EpisodeModel], Error> {
        logger.debug(#function)
        
        do {
            let result = try await performGetEpisodes(from: urls)
            return .success(result)
        } catch {
            logger.debug("Get episodes failed: \(error)")
            return .failure(error)
        }
    }
    
    func performGetEpisodes(from urls: [String]) async throws -> [EpisodeModel] {
        logger.debug(#function)
        
        let ids = urls.compactMap { URL(string: $0)?.lastPathComponent }.compactMap(Int.init)
        let endpoint = APIEndpoint.getEpisodes(ids: ids)
        
        do {
            let data = try await httpsConnection.data(endpoint)
            logger.info("Get episodes successful")
            
            if ids.count == 1 {
                let single = try decoder.decode(EpisodeModel.self, from: data)
                return [single]
            } else {
                return try decoder.decode([EpisodeModel].self, from: data)
            }
        } catch {
            logger.debug("Decoding error: \(error)")
            throw error
        }
    }
}

final class MockEpisodeService: EpisodeServiceProtocol {
    func getEpisodes(from urls: [String]) async -> Result<[EpisodeModel], Error> {
        return .success([.mock, .mock])
    }
}
