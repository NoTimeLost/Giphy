//
//  NetworkError.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 26.01.2023.
//

enum NetworkError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decoding error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
