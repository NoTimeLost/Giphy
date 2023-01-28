//
//  FeedPresenterState.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 27.01.2023.
//

protocol FeedPresenterState {
    var categories: [CategoryListResponse.Category] { get }
    var gifList: [GifListResponse.Gif] { get }
}
