//
//  ViewModel.swift
//  TopMovies
//
//  Created by Andriy Trubchanin on 4/2/18.
//  Copyright © 2018 Trand. All rights reserved.
//

import Foundation

class ViewModel: NSObject {
    
    var movies: [ITunesMovie] = []
    var moviesClient: MoviesClient = MoviesClient()
    
    func fetchMovies(completion: @escaping ()->()) {
        moviesClient.fetchMovies() { movies in
            self.movies = movies
            completion()
        }
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return movies.count
    }
    
    func titleForIndexPath(_ indexPath: IndexPath) -> String {
        return movies[indexPath.row].imName.label
    }
    
}
