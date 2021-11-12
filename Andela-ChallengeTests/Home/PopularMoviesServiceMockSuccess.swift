//
//  PopularMoviesServiceMockSuccess.swift
//  Andela-ChallengeTests
//
//  Created by Renato Mateus on 11/11/21.
//

import Foundation
@testable import Andela_Challenge

class PopularMoviesServiceMockSuccess: PopularMoviesServiceProtocol {
    func fetchData(_ page: Int, completion: @escaping (Result<DataMovie, Error>) -> Void) {
        let fakeMovies: DataMovie = DataMovie(page: 1,
                                                 results: [],
                                                 total_results: 10,
                                                 total_pages: 10)
        completion(.success(fakeMovies))
    }
}
