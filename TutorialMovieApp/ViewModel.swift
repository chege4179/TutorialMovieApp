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
        case failure(underlyingError: Error)
    }
    private(set) var homeStatus: FetchStatus = .notStarted
    private let dataFetcher = DataFetcher()

    var trendingMovies: [Title] = []
    var trendingTV: [Title] = []
    var topRatedMovies: [Title] = []
    var topRatedTV: [Title] = []
    var heroTitle: Title = Title.previewTitles[0]

    func getTrendingMovies() async {
        self.homeStatus = .fetching

        if trendingTV.isEmpty {

            do {

                async let tMovies = dataFetcher.fetchTitles(
                    for: "movie",
                    by: "trending"
                )
                async let tTV = dataFetcher.fetchTitles(
                    for: "tv",
                    by: "trending"
                )
                async let tRMovies = dataFetcher.fetchTitles(
                    for: "movie",
                    by: "top_rated"
                )
                async let tRTV = dataFetcher.fetchTitles(
                    for: "tv",
                    by: "top_rated"
                )

                trendingMovies = try await tMovies
                trendingTV = try await tTV
                topRatedMovies = try await tRMovies
                topRatedTV = try await tRTV
                
                if let title = trendingMovies.randomElement() {
                    heroTitle = title
                }
                
                self.homeStatus = .success
            } catch {
                print(error)
                self.homeStatus = .failure(underlyingError: error)
                return
            }
        } else {
            self.homeStatus = .success
        }
    }
}
