//
//  NowPlaying.swift
//  MovieDB
//
//  Created by Roberto Riquelme on 11/12/18.
//  Copyright © 2018 Roberto Riquelme. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class Client {

    func fetchMovies (completion: @escaping ([Movie]?) -> Void) {
        var parameters = [String:Any]()
        parameters [ParameterKeys.ApiKey] = Constants.ApiKey as Any

        Alamofire.request(
            tmdbURL(withPathExtension: Methods.NowPlaying),
            method: .get,   
            parameters: parameters)
            .validate()
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("Error while fetching movies: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }
                guard let result = response.result.value as? [String: Any],
                    let movies = result["results"] as? [[String: Any]] else {
                        print("Malformed data received from fetchMovies service")
                        completion(nil)
                        return
                }
                let moviesArray = Movie.moviesFromResults(movies)
                completion(moviesArray)
        }

    }

    func fetchImage (path: String, size: String, completion: @escaping (UIImage?) -> Void) {
        let baseURL: URL = URL(string: PosterConstants.secureBaseImageURLString)!
        let url = baseURL.appendingPathComponent(size).appendingPathComponent(path)

        Alamofire.request(
            url,
            method: .get)
            .responseImage { (response) in
                guard let image = response.result.value else {
                    print("Error while fetching movies: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }

                completion(image)
        }

    }

    private func tmdbURL(withPathExtension: String? = nil) -> URL {
        var components = URLComponents()
        components.scheme = Client.Constants.ApiScheme
        components.host = Client.Constants.ApiHost
        components.path = Client.Constants.ApiPath + (withPathExtension ?? "")

        return components.url!
    }

    class func sharedInstance() -> Client {
        struct Singleton {
            static var sharedInstance = Client()
        }
        return Singleton.sharedInstance
    }


}
