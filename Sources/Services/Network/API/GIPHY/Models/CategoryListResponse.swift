//
//  CategoryListResponse.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 26.01.2023.
//

struct CategoryListResponse: Decodable {
    let data: [Category]
    let pagination: Pagination
}

extension CategoryListResponse {
    struct Category: Decodable {
        let name: String
    }
}
