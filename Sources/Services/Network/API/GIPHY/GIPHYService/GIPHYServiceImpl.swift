//
//  GIPHYServiceImpl.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 26.01.2023.
//

final class GIPHYServiceImpl: GIPHYService {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchCategories(offset: Int) async -> Result<CategoryListResponse, NetworkError> {
            await networkService.sendRequest(
                endpoint: GiphyEndpoint.categories,
                offsset: offset,
                responseModel: CategoryListResponse.self
            )
        }
        
        func fetchTrendingGifs(offset: Int) async -> Result<GifListResponse, NetworkError> {
            await networkService.sendRequest(
                endpoint: GiphyEndpoint.trending,
                offsset: offset,
                responseModel: GifListResponse.self
            )
        }
        
        func searchByCategory(offset: Int, categoryName: String) async -> Result<GifListResponse, NetworkError> {
            await networkService.sendRequest(
                endpoint: GiphyEndpoint.search(categoryName),
                offsset: offset,
                responseModel: GifListResponse.self
            )
        }
}
