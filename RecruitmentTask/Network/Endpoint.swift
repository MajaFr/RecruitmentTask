//
//  Endpoint.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
}

enum APIEndpoint {
    case getCharacters
    case getEpisodes(ids: [Int])
}

extension APIEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getCharacters:
            return "character"
        case .getEpisodes(let ids):
            return "episode/\(ids.map(String.init).joined(separator: ","))"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCharacters, .getEpisodes:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}

