//
//  DetailMovieServiceMockFailure.swift
//  Andela-ChallengeTests
//
//  Created by Renato Mateus on 11/11/21.
//

import Foundation
@testable import Andela_Challenge

class DetailMovieServiceMockFailure: DetailMovieServiceProtocol {
    func fetchData(movieId: Int, completion: @escaping (Result<DetailMovie, Error>) -> Void) {
        completion(.failure(NSError(domain: "No data was downloaded.",
                                    code: 400,
                                    userInfo: nil)))
    }
}
