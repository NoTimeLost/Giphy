//
//  GiphyEndpoint.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 26.01.2023.
//

import Foundation

enum GiphyEndpoint {
    case trending
    case categories
    case search(String)
}

extension GiphyEndpoint: Endpoint {

    var version: String { "1" }

    var path: String {
        switch self {
        case .trending:
            return "/gifs/trending"
        case .categories:
            return "/gifs/categories"
        case .search:
            return "/gifs/search"
        }
    }
    
    var method: RequestMethod { .get }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let queryParameter):
            return [
                URLQueryItem(name: "q", value: queryParameter)
            ]
        default: return []
        }
    }
    
    var header: [HTTPHeader]? { nil }
    
    var body: Data? { nil }
}
