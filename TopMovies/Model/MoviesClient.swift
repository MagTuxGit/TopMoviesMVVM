//
//  MoviesClient.swift
//  TopMovies
//
//  Created by Andriy Trubchanin on 4/2/18.
//  Copyright © 2018 Trand. All rights reserved.
//

import Foundation

class MoviesClient {
    
    func fetchMovies(completion: @escaping ([ITunesMovie])->()) {
        let moviesUrl: String = "http://itunes.apple.com/us/rss/topmovies/limit=50/json"
        guard let url = URL(string: moviesUrl) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            // check for any errors
            guard error == nil else {
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: responseData, options: [])) as? JsonDict,
                let moviesJson = json.getDict("feed")?.getArray("entry") else {
                    print("Error: JSON fail")
                    completion([])
                    return
            }
            
            let movies = moviesJson.flatMap({ try? ITunesMovie($0.json) })
            completion(movies)
        }
        task.resume()
    }
    
}
