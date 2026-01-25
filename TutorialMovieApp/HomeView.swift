//
//  HomeView.swift
//  TutorialMovieApp
//
//  Created by Peter Chege on 16/01/2026.
//

import SwiftUI

struct HomeView: View {

    let viewModel = ViewModel()

    @State private var titleDetailPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $titleDetailPath) {
            GeometryReader { geo in
                ScrollView(.vertical) {
                    switch viewModel.homeStatus {

                    case .success:
                        LazyVStack {

                            AsyncImage(
                                url: URL(
                                    string: viewModel.heroTitle.posterPath ?? ""
                                )
                            ) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .overlay {
                                        LinearGradient(
                                            stops: [
                                                Gradient.Stop(
                                                    color: .clear,
                                                    location: 0.8
                                                ),
                                                Gradient.Stop(
                                                    color: .gradient,
                                                    location: 1
                                                ),
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    }

                            } placeholder: {
                                ProgressView()

                            }.frame(
                                width: geo.size.width,
                                height: geo.size.height * 0.85
                            )
                            HStack {
                                Button {
                                    titleDetailPath.append(viewModel.heroTitle)
                                } label: {
                                    Text(Constants.playString)
                                        .ghostButtonStyle()

                                }

                                Button {

                                } label: {
                                    Text(Constants.downloadString)
                                        .ghostButtonStyle()
                                }
                            }
                            HorizontalListView(
                                header: Constants.trendingTVString,
                                titles: viewModel.trendingMovies,
                                onSelect: { title in
                                    titleDetailPath.append(title)
                                
                                }
                            )
                            HorizontalListView(
                                header: Constants.trendingTVString,
                                titles: viewModel.trendingTV,
                                onSelect: { title in
                                    titleDetailPath.append(title)
                                
                                }
                            )
                            HorizontalListView(
                                header: Constants.topRatedTVString,
                                titles: viewModel.topRatedTV,
                                onSelect: { title in
                                    titleDetailPath.append(title)
                                
                                }
                            )
                            HorizontalListView(
                                header: Constants.topRatedMovieString,
                                titles: viewModel.topRatedMovies,
                                onSelect: { title in
                                    titleDetailPath.append(title)
                                
                                }
                            )
                        }
                        .navigationDestination(for: Title.self) { title in
                            TitleDetailView(title: title)
                        }

                    case .failure(let error):
                        Text("\(error.localizedDescription)")

                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                            .frame(
                                width: geo.size.width,
                                height: geo.size.height
                            )

                    }

                }.task {
                    await viewModel.getTrendingMovies()
                }

            }
        }
    }
}

#Preview {
    HomeView()
}
