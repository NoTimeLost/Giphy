//
//  GIPHYService.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 26.01.2023.
//

protocol GIPHYService {
    func fetchCategories(offset: Int) async -> Result<CategoryListResponse, NetworkError>
    func fetchTrendingGifs(offset: Int) async -> Result<GifListResponse, NetworkError>
    func searchByCategory(offset: Int, categoryName: String) async -> Result<GifListResponse, NetworkError>
}
