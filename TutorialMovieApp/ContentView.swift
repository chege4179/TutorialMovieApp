//
//  ContentView.swift
//  TutorialMovieApp
//
//  Created by Peter Chege on 11/01/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab(Constants.homeString,systemImage: Constants.homeIconString){
                HomeView()
            }
            Tab(Constants.upcomingString,systemImage: Constants.upcomingIconString){
                Text(Constants.upcomingString)
            }
            Tab(Constants.searchString,systemImage: Constants.searchIconString){
                Text("Search")
            }
            Tab(Constants.downloadString,systemImage: Constants.downloadIconString){
                Text("Download")
            }
        }.onAppear{
            if let config = APIConfig.shared {
                print(config.tmdbAPIKey)
                print(config.tmdbBaseURL)
            }
        }
    }
}

#Preview {
    ContentView()
}
