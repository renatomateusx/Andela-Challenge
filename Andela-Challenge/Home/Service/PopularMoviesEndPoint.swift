//
//  PopularMoviesEndPoint.swift
//  Andela-Challenge
//
//  Created by Renato Mateus on 11/11/21.
//

import Foundation

struct PopularMoviesEndpoint {
    let page: Int
    
    var token: String {
        return Constants.token
    }

    var host: String {
        return Constants.movieDbURL
    }

    var path: String {
        return "/popular?api_key=\(token)&&page=\(page)"
    }
    
    var url: URL {
        return URL(string: "\(host)\(path)")!
    }

    var headers: [String: String] {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
