//
//  URLManager.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import Foundation
import OSLog

final class URLManager {
    
    private let baseURL: URL
    private let logger = Logger(subsystem: "URLManager", category: "Connection")
    
    init(baseURLString: String = "https://rickandmortyapi.com/api") {
        if let url = URL(string: baseURLString) {
            self.baseURL = url
        } else {
            logger.warning("Invalid base URL.")
            self.baseURL = URL(string: "https://rickandmortyapi.com/api")!
        }
    }
    
    func makeURL(for path: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.path += path.hasPrefix("/") ? path : "/" + path
        components?.queryItems = queryItems
        return components?.url
    }
}
