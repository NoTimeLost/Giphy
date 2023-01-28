//
//  NetworkService.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 26.01.2023.
//

import Foundation

protocol NetworkService {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        offsset: Int,
        responseModel: T.Type
    ) async -> Result<T, NetworkError>
}
