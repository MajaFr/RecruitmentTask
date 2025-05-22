//
//  HttpsConnection.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import Foundation
import OSLog

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class HttpsConnection: NSObject {
    
    private let logger = Logger(subsystem: "HttpsConnection", category: "Connection")
    private let session: URLSession
    private let urlManager: URLManager
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared) {
        self.session = session
        self.urlManager = URLManager()
        self.decoder = JSONDecoder()
    }
    
    func httpData(for request: URLRequest) async throws -> Data {
        logRequest(request)
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ErrorModel(
                errorCode: ErrorCodes.responseError.reason,
                reasonCode: "Invalid Response",
                description: "Server response could not be parsed"
            )
        }
        
        logResponse(data: data, response: httpResponse)
        
        switch httpResponse.statusCode {
        case 200..<300:
            return data
        default:
            throw ErrorModel(
                errorCode: ErrorCodes.responseError.reason,
                reasonCode: "StatusCode_\(httpResponse.statusCode)",
                description: "Server responded with code \(httpResponse.statusCode)"
            )
        }
    }
    
    func data<T: Decodable>(_ endpoint: Endpoint, body: Encodable? = nil) async throws -> T {
        let request = try await makeRequest(from: endpoint, body: body)
        let data = try await httpData(for: request)
        return try decoder.decode(T.self, from: data)
    }
    
    func data(_ endpoint: Endpoint, body: Encodable? = nil) async throws -> Data {
        let request = try await makeRequest(from: endpoint, body: body)
        return try await httpData(for: request)
    }
    
    private func makeRequest(from endpoint: Endpoint, body: Encodable?) async throws -> URLRequest {
        let url = try makeUrl(from: endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        return request
    }
    
    private func makeUrl(from endpoint: Endpoint) throws -> URL {
        guard let url = urlManager.makeURL(for: endpoint.path, queryItems: endpoint.queryItems) else {
            throw ErrorModel(
                errorCode: ErrorCodes.invalidURL.reason,
                reasonCode: "URLConstruction",
                description: "Failed to build the request URL"
            )
        }
#if DEBUG
        logger.info("Constructed URL: \(url)")
#endif
        return url
    }
    
    private func makeBody(from params: [String: Any]?) -> Data? {
        guard let params, !params.isEmpty else { return nil }
        return try? JSONSerialization.data(withJSONObject: params)
    }
    
    private func logRequest(_ request: URLRequest) {
#if DEBUG
        logger.debug("===REQUEST===")
        logger.debug("Request to: \(request.url?.absoluteString ?? "")")
        logger.debug("Method: \(request.httpMethod ?? "")")
        logger.debug("Headers: \(request.allHTTPHeaderFields ?? [:])")
        logger.debug("==================")
#endif
    }
    
    private func logResponse(data: Data, response: HTTPURLResponse) {
#if DEBUG
        logger.debug("===RESPONSE===")
        logger.debug("Response Status Code: \(response.statusCode)")
        logger.debug("URL: \(response.url?.absoluteString ?? "N/A")")
        logger.debug("==================")
#endif
    }
}

enum ErrorCodes: Error {
    case invalidURL
    case JSONDecodingError
    case responseError
    case requestError
    case unknownError

    
    var reason: String {
        switch self {
        case .invalidURL:
            return "INVALID_URL"
        case .JSONDecodingError:
            return "JSON_DECODING_ERROR"
        case .requestError:
            return "REQUEST_CODE"
        case .unknownError:
            return "UNKNOWN_ERROR"
        case .responseError:
            return "RESPONSE_ERROR"
        }
    }
}

struct ErrorModel: Error, Codable {
    let errorCode: String
    let reasonCode: String
    let description: String
    
    init(errorCode: String, reasonCode: String, description: String) {
        self.errorCode = errorCode
        self.reasonCode = reasonCode
        self.description = description
    }
    
    func toString() -> String {
        return "{ errorCode=\(errorCode), reasonCode=\(reasonCode), description=\(description) }"
    }
}
