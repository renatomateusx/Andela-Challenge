//
//  DetailViewModel.swift
//  Andela-Challenge
//
//  Created by Renato Mateus on 11/11/21.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func onSuccessFetchingDetail(movie: DetailMovie)
    func onFailureFetchingDetail(error: Error)
}

class DetailViewModel {
    
    // MARK: - Private Properties
    let detailMovieService: DetailMovieServiceProtocol
    var delegate: DetailViewModelDelegate?
    
    // MARK: - Inits
    init(with service: DetailMovieServiceProtocol) {
        self.detailMovieService = service
    }
    
    func fetchData(_ id: Int) {
        detailMovieService.fetchData(movieId: id) { result in
            switch result {
            
            case .success(let movie):
                self.delegate?.onSuccessFetchingDetail(movie: movie)
            case .failure(let error):
                self.delegate?.onFailureFetchingDetail(error: error)
            }
        }
    }
}
