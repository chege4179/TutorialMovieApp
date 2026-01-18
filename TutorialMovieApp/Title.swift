//
//  Title.swift
//  TutorialMovieApp
//
//  Created by Peter Chege on 17/01/2026.
//

import Foundation

struct APIObject: Decodable {
    var results: [Title] = []
}


struct Title:Decodable, Identifiable {
    var id: Int?
    var title: String?
    var name:String?
    var overview: String?
    var posterPath: String?
    
    
    
    
    static var previewTitles = [
            Title(id: 1, title: "BeetleJuice1", name: "BeetleJuice", overview: "A movie about BeetleJuice", posterPath: Constants.testTitleURL),
            Title(id: 2, title: "Pulp Fiction1", name: "Pulp Fiction", overview: "A movie about Pulp Fiction", posterPath: Constants.testTitleURL2),
            Title(id: 3, title: "The Dark Knight1", name: "The Dark Knight", overview: "A movie about the Dark Knight", posterPath: Constants.testTitleURL3)
        ]
}
