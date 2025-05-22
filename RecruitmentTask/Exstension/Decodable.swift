//
//  Decodable.swift
//  RecruitmentTask
//
//  Created by Maja Frąk on 22/05/2025.
//

import Foundation

extension Decodable {
    static func fromJsonData(_ data: Data, _ decoder: JSONDecoder = JSONDecoder()) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }
}
