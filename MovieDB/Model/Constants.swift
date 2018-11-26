//
//  Constants.swift
//  MovieDB
//
//  Created by Roberto Riquelme on 11/11/18.
//  Copyright © 2018 Roberto Riquelme. All rights reserved.
//

import Foundation

extension Client {

    struct Constants {
        static let ApiKey = "1fb487f53d810ef924294c29fd9812e9"
        static let ApiScheme = "https"
        static let ApiHost = "api.themoviedb.org"
        static let ApiPath = "/3"
    }

    struct Methods {
        static let NowPlaying = "/movie/now_playing"
        static let SearchMovie = "/search/movie"
        static let Config = "/configuration"
    }

    struct PosterConstants {
        static let secureBaseImageURLString =  "https://image.tmdb.org/t/p/"
        static let posterSizes = ["w92", "w154", "w185", "w342", "w500", "w780", "original"]
        static let backdropSizes = ["w300", "w780", "h1280", "original"]
        static let profileSizes = ["w45", "w185", "h632", "original"]
        static let RowPoster = posterSizes[2]
        static let DetailPoster = posterSizes[4]
        static let BackdropImage = backdropSizes[1]
    }

    struct ParameterKeys {
        static let ApiKey = "api_key"
        static let Query = "query"
    }

    struct JSONResponseKeys {
        static let MovieID = "id"
        static let MovieTitle = "title"
        static let MoviePosterPath = "poster_path"
        static let MovieBackdropPath = "backdrop_path"
        static let Overview = "overview"

    }

}

