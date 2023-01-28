//
//  Endpoint.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 26.01.2023.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var version: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [HTTPHeader]? { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem] { get }

    func request(offset: Int) -> URLRequest
}

extension Endpoint {
    var scheme: String {
        return URLScheme.https.rawValue
    }

    var host: String {
        return GIPHYConstant.baseURL
    }

    var apiKey: String {
        return KeyStorage.gifAPIKey
    }

    func request(offset: Int) -> URLRequest {
        var components = URLComponents()
        var baseQueryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "limit", value: "\(GIPHYConstant.requestItemsLimit)")
        ]
        
        baseQueryItems.append(contentsOf: queryItems)
        
        components.scheme = scheme
        components.host = host
        components.path = "/v\(version)\(path)"
        
        components.queryItems = baseQueryItems
        
        guard let url = components.url else {
            fatalError(URLError(.unsupportedURL).localizedDescription)
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        
        header?.forEach { (header) in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.field)
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return urlRequest
        
    }
}
