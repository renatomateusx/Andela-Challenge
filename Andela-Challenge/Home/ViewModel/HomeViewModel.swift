//
//  HomeViewModel.swift
//  Andela-Challenge
//
//  Created by Renato Mateus on 11/11/21.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func onSuccessFetchingProducts(movies: DataMovie)
    func onFailureFetchingProducts(error: Error)
}

class HomeViewModel {
    
    // MARK: - Private Properties
    let productsService: PopularMoviesServiceProtocol
    var delegate: HomeViewModelDelegate?
    // MARK: - Inits
    
    init(with service: PopularMoviesServiceProtocol) {
        self.productsService = service
    }
    
    func fetchData(_ page: Int) {
        productsService.fetchData(page) { result in
            switch result {
            
            case .success(let movies):
                self.delegate?.onSuccessFetchingProducts(movies: movies)
            case .failure(let error):
                self.delegate?.onFailureFetchingProducts(error: error)
            }
        }
    }
}
