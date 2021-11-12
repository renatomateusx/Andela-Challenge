//
//  DetailmovieServiceMockSuccess.swift
//  Andela-ChallengeTests
//
//  Created by Renato Mateus on 11/11/21.
//

import Foundation
@testable import Andela_Challenge

class DetailMovieServiceMockSuccess: DetailMovieServiceProtocol {
    func fetchData(movieId: Int, completion: @escaping (Result<DetailMovie, Error>) -> Void) {
        let fakeDetailMovie: DetailMovie = DetailMovie(original_title: "Dune",
                                                     overview: "Paul Atreides, a brilliant and gifted young man born into a great destiny beyond his understanding, must travel to the most dangerous planet in the universe to ensure the future of his family and his people. As malevolent forces explode into conflict over the planet's exclusive supply of the most precious resource in existence-a commodity capable of unlocking humanity's greatest potential-only those who can conquer their fear will survive.",
                                                     poster_path: "/d5NXSklXo0qyIYkgV94XAgMIckC.jpg")
        completion(.success(fakeDetailMovie))
    }
}
