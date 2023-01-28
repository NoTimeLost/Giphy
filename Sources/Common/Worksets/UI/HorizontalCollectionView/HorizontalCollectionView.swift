//
//  HorizontalCollectionView.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 28.01.2023.
//

import UIKit

final class HorizontalCollectionView: UICollectionView {

    // MARK: - Private properties

    private let layout = UICollectionViewFlowLayout()

    // MARK: - Initialization

    init() {
        super.init(frame: .zero, collectionViewLayout: layout)

        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
