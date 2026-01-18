//
//  HomeView.swift
//  TutorialMovieApp
//
//  Created by Peter Chege on 16/01/2026.
//

import SwiftUI

struct HomeView: View {
    var heroTestTitle = Constants.testTitleURL
    let viewModel = ViewModel()
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                switch viewModel.homeStatus {
                    
                case .success:
                    LazyVStack {
                        
                        AsyncImage(url: URL(string: heroTestTitle)){ image in
                            image.resizable()
                                .scaledToFit()
                                .overlay{
                                    LinearGradient(
                                        stops: [
                                            Gradient.Stop(color: .clear, location:0.8),
                                            Gradient.Stop(color: .gradient, location:1)
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom)
                                }
                            
                        }placeholder: {
                            ProgressView()
                            
                        }.frame(width: geo.size.width,height: geo.size.height * 0.85)
                        HStack {
                            Button() {
                                
                            }label: {
                                Text(Constants.playString)
                                    .ghostButtonStyle()
                                
                            }
                            
                            Button() {
                                
                            }label: {
                                Text(Constants.downloadString)
                                    .ghostButtonStyle()
                            }
                        }
                        HorizontalListView(header: Constants.trendingTVString, titles: viewModel.trendingMovies)
    //                    HorizontalListView(header: Constants.trendingMovieString)
    //                    HorizontalListView(header: Constants.topRatedTVString)
    //                    HorizontalListView(header: Constants.topRatedMovieString)
                    }
                    
                    
                case .failure(let error):
                    Text("\(error.localizedDescription)")
                    
                case .notStarted:
                    EmptyView()
                case .fetching:
                    ProgressView()
                    
                }
                
            }.task {
                await viewModel.getTrendingMovies()
            }
        
        }
    }
}

#Preview {
    HomeView()
}
