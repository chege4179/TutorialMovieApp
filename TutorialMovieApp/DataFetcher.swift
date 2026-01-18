//
//  DataFetcher.swift
//  TutorialMovieApp
//
//  Created by Peter Chege on 17/01/2026.
//

import Foundation


let tmdbBaseUrl = APIConfig.shared?.tmdbBaseURL
let tmdbApiKey = APIConfig.shared?.tmdbAPIKey

struct DataFetcher {
    func fetchTitles(for media:String) async throws -> [Title] {
        guard let baseUrl = tmdbBaseUrl else {
            throw NetworkError.missingConfig
        }
        
        guard let apiKey = tmdbApiKey else {
            throw NetworkError.missingConfig
        }
        
        guard let fetchingTitlesUrl = URL(string: baseUrl)?
            .appending(path: "3/trending/\(media)/day")
            .appending(queryItems: [
                URLQueryItem(name: "api_key", value: apiKey)
            ]) else {
            throw NetworkError.urlBuildFailed
        }
        
        print(fetchingTitlesUrl)
        
        let (data,urlResponse) = try await URLSession.shared.data(from: fetchingTitlesUrl)
        
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badURLResponse(
                underlyingError:NSError(
                    domain: "DataFetcher",
                    code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                    userInfo: [NSLocalizedDescriptionKey:"Invalid HTTP response"]))
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var titles =  try decoder.decode(APIObject.self, from: data).results
        Constants.addPosterPath(to: &titles)
        return titles
    }
    
    
}
