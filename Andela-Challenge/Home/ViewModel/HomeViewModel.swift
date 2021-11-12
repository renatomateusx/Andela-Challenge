//
//  HomeViewModel.swift
//  Andela-Challenge
//
//  Created by Renato Mateus on 11/11/21.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func onSuccessFetchingMovies(movies: DataMovie)
    func onFailureFetchingMovies(error: Error)
}

class HomeViewModel {
    
    // MARK: - Private Properties
    let moviesService: PopularMoviesServiceProtocol
    var delegate: HomeViewModelDelegate?
    // MARK: - Inits
    
    init(with service: PopularMoviesServiceProtocol) {
        self.moviesService = service
    }
    
    func fetchData(_ page: Int) {
        moviesService.fetchData(page) { result in
            switch result {
            
            case .success(let movies):
                self.delegate?.onSuccessFetchingMovies(movies: movies)
            case .failure(let error):
                self.delegate?.onFailureFetchingMovies(error: error)
            }
        }
    }
}
