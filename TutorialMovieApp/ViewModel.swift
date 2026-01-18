//
//  ViewModel.swift
//  TutorialMovieApp
//
//  Created by Peter Chege on 17/01/2026.
//

import Foundation


@Observable
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failure(underlyingError:Error)
    }
    private(set) var homeStatus:FetchStatus = .notStarted
    private let dataFetcher = DataFetcher()
    var trendingMovies:[Title] = []
    
    
    func getTrendingMovies() async {
        self.homeStatus = .fetching
        do {
            
            trendingMovies = try await dataFetcher.fetchTitles(for: "movie")
            self.homeStatus = .success
        } catch {
            print(error)
            self.homeStatus = .failure(underlyingError: error)
            return
        }
    }
}

