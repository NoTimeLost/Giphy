//
//  MosaicCollectionView.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 28.01.2023.
//

import UIKit

final class MosaicCollectionView: UICollectionView {

    // MARK: - Initialization

    init() {
        super.init(frame: .zero, collectionViewLayout: .mosaicLayout())

        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
