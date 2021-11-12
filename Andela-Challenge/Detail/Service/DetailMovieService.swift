//
//  DetailMovieService.swift
//  Andela-Challenge
//
//  Created by Renato Mateus on 11/11/21.
//

import Foundation

protocol DetailMovieServiceProtocol: AnyObject {
    func fetchData(movieId: Int, completion: @escaping(Result<DetailMovie, Error>) -> Void)
}

class DetailMovieService {
    private var service: NetworkService
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
}

extension DetailMovieService: DetailMovieServiceProtocol {
    func fetchData(movieId: Int,
                   completion: @escaping(Result<DetailMovie, Error>) -> Void) {
        let endpoint = DetailMovieEndpoint(id: movieId)
        _ = service.request(for: endpoint.url, completion: completion)
    }
}
