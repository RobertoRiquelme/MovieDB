//
//  Search.swift
//  MovieDB
//
//  Created by Roberto Riquelme on 11/12/18.
//  Copyright © 2018 Roberto Riquelme. All rights reserved.
//

import Foundation

struct Movie {

    let id: Int
    let title: String
    let posterPath: String?
    let overview: String?
    let backdropPath: String?

    init(dictionary: [String:Any]) {
        id = dictionary[Client.JSONResponseKeys.MovieID] as! Int
        title = dictionary[Client.JSONResponseKeys.MovieTitle] as! String
        posterPath = dictionary[Client.JSONResponseKeys.MoviePosterPath] as? String
        overview = dictionary[Client.JSONResponseKeys.Overview] as? String
        backdropPath = dictionary[Client.JSONResponseKeys.MovieBackdropPath] as? String
    }

    static func moviesFromResults(_ results: [[String:Any]]) -> [Movie] {

        var movies = [Movie]()

        for result in results {
            movies.append(Movie(dictionary: result))
        }

        return movies
    }
}

extension Movie: Equatable {
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}
