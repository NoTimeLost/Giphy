//
//  FeedScreenPresenter.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 27.01.2023.
//

import Foundation

final class FeedScreenPresenter {

    // MARK: - Public properties

    weak var view: FeedScreenDisplayLogic?

    var gifList: [GifListResponse.Gif] = []
    var categories = [
        CategoryListResponse.Category(name: "Trending")
    ]

    // MARK: - Private properties

    private let service: GIPHYService

    private var currentCategory = "Trending"

    private var gifPaginationTotalCount = 0
    private var categoryPaginationTotalCount = 0

    private var gifOffset = 0
    private var categoryOffset = 0

    // MARK: - Initialization

    init(service: GIPHYService) {
        self.service = service
    }
}

// MARK: - FeedPresenterState

extension FeedScreenPresenter: FeedPresenterState {}

// MARK: - FeedScreenPresentationLogic

extension FeedScreenPresenter: FeedScreenPresentationLogic {

    func loadData() {
        fetchCategories()
        fetchTrendingGifs(needClearList: true)
    }

    func updateCategory(for indexPath: IndexPath) {
        currentCategory = categories[indexPath.row].name
        fetchBy(category: currentCategory, needClearList: true)
        gifOffset = .zero
    }

    func updateGifCollection(for indexPath: IndexPath) {
        guard
            indexPath.row == gifOffset,
            gifOffset <= gifPaginationTotalCount
        else {
            return
        }
        
        gifOffset += Constant.offset
        switch currentCategory {
        case "Trending":
            fetchTrendingGifs(needClearList: false)
        default:
            fetchBy(category: currentCategory, needClearList: false)
        }
    }

    func updateCategoryCollection(for indexPath: IndexPath) {
        guard
            indexPath.row == categoryOffset,
            categoryOffset <= categoryPaginationTotalCount
        else {
            return
        }

        categoryOffset += Constant.offset
        fetchCategories()
    }
}

// MARK: - Private functions

private extension FeedScreenPresenter {

    func fetchTrendingGifs(needClearList: Bool) {
        Task { [weak self] in
            guard let self = self else { return }
    
            let result = await service.fetchTrendingGifs(offset: gifOffset)

            switch result {
            case .success(let gifList):
                if needClearList {
                    self.gifList = []
                }
                self.gifPaginationTotalCount = gifList.pagination.totalCount
                self.gifList.append(contentsOf: gifList.data)

                await MainActor.run {
                    self.view?.reloadGif()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchCategories() {
        Task { [weak self] in
            guard let self = self else { return }

            let result = await service.fetchCategories(offset: categoryOffset)

            switch result {
            case .success(let categories):
                self.categoryPaginationTotalCount = categories.pagination.totalCount
                self.categories.append(contentsOf: categories.data)

                await MainActor.run {
                    self.view?.reloadCategory()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchBy(category: String, needClearList: Bool) {
        Task { [weak self] in
            guard let self = self else { return }

            let result = await service.searchByCategory(offset: gifOffset, categoryName: category)

            switch result {
            case .success(let gifList):
                if needClearList {
                    self.gifList = []
                }
                self.gifList.append(contentsOf: gifList.data)

                await MainActor.run {
                    self.view?.reloadGif()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Constant

private extension FeedScreenPresenter {

    enum Constant {
        static let offset = 20
    }
}
