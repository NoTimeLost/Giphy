//
//  GridCollectionView.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 28.01.2023.
//

import UIKit

final class GridCollectionView: UICollectionView {

    // MARK: - GridCollectionViewFlowLayoutDelegate

    weak var gridLayoutDelegate: GridCollectionViewFlowLayoutDelegate?

    // MARK: - Private properties

    private let gridCollectionViewLayout = GridCollectionViewFlowLayout()

    // MARK: - Initialization

    init() {
        super.init(frame: .zero, collectionViewLayout: gridCollectionViewLayout)

        translatesAutoresizingMaskIntoConstraints = false
        gridCollectionViewLayout.delegate = gridLayoutDelegate
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getHeight(contentWidth: String, contentHeight: String) -> CGFloat {
        let downloadedImageWidth = CGFloat(NSString(string: contentWidth).floatValue)
        let downloadedImageHeight = CGFloat(NSString(string: contentHeight).floatValue)
        let collectionViewHalfWidth = (bounds.width / 2)
        let ratio = collectionViewHalfWidth / CGFloat(downloadedImageWidth)
        
        return downloadedImageHeight * ratio
    }
}
