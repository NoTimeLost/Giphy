//
//  NetworkServiceImpl.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 28.01.2023.
//

import Foundation

final class NetworkServiceImpl: NetworkService {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        offsset: Int,
        responseModel: T.Type
    ) async -> Result<T, NetworkError> {
        do {
            let (data, response) = try await URLSession.shared.data(
                for: endpoint.request(offset: offsset),
                delegate: nil
            )
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard
                    let decodedResponse = try? decoder.decode(responseModel, from: data)
                else {
                    return .failure(.decode)
                }

                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
            
        } catch {
            return .failure(.unknown)
        }
    }
}
