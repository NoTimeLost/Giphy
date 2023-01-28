//
//  FeedScreenPresentationLogic.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 27.01.2023.
//

import Foundation

protocol FeedScreenPresentationLogic {
    func loadData()
    func updateCategory(for indexPath: IndexPath)
    func updateGifCollection(for indexPath: IndexPath)
    func updateCategoryCollection(for indexPath: IndexPath)
}
 
