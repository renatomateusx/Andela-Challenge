//
//  PopularMoviesService.swift
//  Andela-Challenge
//
//  Created by Renato Mateus on 11/11/21.
//

import Foundation

protocol PopularMoviesServiceProtocol: AnyObject {
    func fetchData(_ page: Int, completion: @escaping(Result<DataMovie, Error>) -> Void)
}

class PopularMoviesService {
    private var service: NetworkService
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
}

extension PopularMoviesService: PopularMoviesServiceProtocol {
    func fetchData(_ page: Int, completion: @escaping(Result<DataMovie, Error>) -> Void) {
        let endpoint = PopularMoviesEndpoint(page: page)
        _ = service.request(for: endpoint.url, completion: completion)
    }
}
