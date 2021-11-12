//
//  PopularMoviesServiceMockFailure.swift
//  Andela-ChallengeTests
//
//  Created by Renato Mateus on 11/11/21.
//

import Foundation
@testable import Andela_Challenge

class PopularMoviesServiceMockFailure: PopularMoviesServiceProtocol {
    func fetchData(_ page: Int, completion: @escaping (Result<DataMovie, Error>) -> Void) {
        completion(.failure(NSError(domain: "No data was downloaded.",
                                    code: 400,
                                    userInfo: nil)))
    }
}
