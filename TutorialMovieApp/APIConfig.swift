//
//  APIConfig.swift
//  TutorialMovieApp
//
//  Created by Peter Chege on 17/01/2026.
//

import Foundation

struct APIConfig:Decodable {
    var tmdbBaseURL: String
    var tmdbAPIKey: String
    
    
    static let shared:APIConfig? = {
        do{
            return try loadConfig()
        }catch {
            print("Failed to initialize API Config: \(error.localizedDescription)")
            return nil
        }
    }()
    
    private static func loadConfig() throws -> APIConfig {
        guard let url = Bundle.main.url(forResource: "APIConfig", withExtension: "json") else {
            throw APIConfigError.fileNotFound
        }
        do {
            let data  = try Data(contentsOf: url)
            return try JSONDecoder().decode(APIConfig.self, from: data)
        }catch let error as DecodingError{
           throw APIConfigError.decodingFailed(underlyingError: error)
        }catch {
            throw APIConfigError.dataLoadingFailed(underlyingError: error)
        }
    }
}
