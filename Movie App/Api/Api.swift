//
//  Api.swift
//  Movie App
//
//  Created by Alaa Adel on 9/21/20.
//  Copyright © 2020 Alaa Adel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Api: NSObject {
    class func ratedMovies(completion: @escaping (_ error: Error?, _ movies: [RatedMovies]?)-> Void) {
        
        let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=cc3e0229bdf2038f114de12bd9214f05&language=en-US&page=1"
        AF.request(url).response {(response) in
            
            switch response.result {
            case .failure(let error):
                completion(error, nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                guard let results = json["results"].array else {
                    completion(nil,nil)
                    return
                }
                
                var movies = [RatedMovies]()
                for result in results {
                    guard let result = result.dictionary else {return}
                    let movie = RatedMovies()
                    movie.id = result["id"]?.int ?? 0
                    movie.title = result["title"]?.string ?? ""
                    movie.poster_path =  result["poster_path"]?.string ?? ""
                    movie.overview = result["overview"]?.string ?? ""
                    movies.append(movie)
                }
                completion(nil,movies)
        }
    }
  }
    class func movieDetails(movieID: Int,completion: @escaping (_ error: Error?, _ movies: DetailsMovies?)-> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=cc3e0229bdf2038f114de12bd9214f05&language=en-US"
        AF.request(url).response {(response) in
            switch response.result {
                case .failure(let error):
                    completion(error, nil)
                    print(error)
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    if json != JSON.null {
                        
                        let moviesObject = DetailsMovies(id: json["id"].int, title: json["original_title"].string, backdrop_path: json["backdrop_path"].string, overview: json["overview"].string,release_date: json["release_date"].string,vote_average: json["vote_average"].float, vote_count: json["vote_count"].int)
                        completion(nil,moviesObject)
                }
            }
        }
    }
}
