//
//  Errors.swift
//  TutorialMovieApp
//
//  Created by Peter Chege on 17/01/2026.
//

import Foundation

enum APIConfigError: Error,LocalizedError {
    case fileNotFound
    case dataLoadingFailed(underlyingError:Error)
    case decodingFailed(underlyingError:Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "File not found"
        case .dataLoadingFailed(underlyingError: let error):
            return "Failed to load data with error: \(error.localizedDescription)"
        case .decodingFailed(underlyingError: let error):
            return "Failed to decode data with error: \(error.localizedDescription)"
        }
    }
    
}


enum NetworkError:Error, LocalizedError {
    case badURLResponse(underlyingError:Error)
    case missingConfig
    case urlBuildFailed
    
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(underlyingError: let error):
            return "Bad URL Response with error: \(error.localizedDescription)"
        case .missingConfig:
            return "Missing Configuration"
        case .urlBuildFailed:
            return "Faild to build URL"
        }
        
    }
}
