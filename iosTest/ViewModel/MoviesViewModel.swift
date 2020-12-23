//
//  MoviesViewModel.swift
//  iosTest
//
//  Created by Omar on 21/12/20.
//

import Foundation

class MoviesViewModel {
    
    var error: Bool? {
        didSet { self.showAlertClosure?() }
    }
    
    var movies = [Movie]()
    var movieDetails: MovieDetailResponse?
    
    var page = 1
    var totalPages = 0
    var isFetchingResults = false
    var showAlertClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var didFinishFetch: (() -> Void)?
    
    func fetchMovies() {
        isFetchingResults = true
        Api.shared.getMoviesPer(page: page) { [weak self] response, error in
            guard let self = self else { return }
            self.isFetchingResults = false
            if error {
                self.error = error
                return
            }
            
            self.totalPages = response?.totalPages ?? 0
            guard let movies = response?.movies else { return }
            self.movies.append(contentsOf: movies)
            
            self.updateLoadingStatus?()
            self.didFinishFetch?()
        }
    }
    
    func fetchMovie(id: Int) {
        Api.shared.getMovieBy(id: id) { [weak self] response, error in
            guard let self = self else { return }
            
            if error {
                self.error = error
                return
            }
            
            self.movieDetails = response
            self.didFinishFetch?()
        }
    }
    
}
