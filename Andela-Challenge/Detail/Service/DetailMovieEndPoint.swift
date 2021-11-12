//
//  DetailMovieEndPoint.swift
//  Andela-Challenge
//
//  Created by Renato Mateus on 11/11/21.
//

import Foundation

struct DetailMovieEndpoint {
    let id: Int
    
    var token: String {
        return Constants.token
    }

    var host: String {
        return Constants.movieDbURL
    }

    var path: String {
        return "/\(id)?api_key=\(token)"
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
