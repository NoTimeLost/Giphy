//
//  UICollectionViewLayout+Ext.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 28.01.2023.
//

import UIKit

extension UICollectionViewLayout {

    static func mosaicLayout() -> UICollectionViewCompositionalLayout {
        let smallItemLeft = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
        )
        smallItemLeft.contentInsets.trailing = 4

        let smallItemRight = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
        )
        smallItemRight.contentInsets.leading = 4

        let horizontalGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.5)
        )
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: horizontalGroupSize,
            subitems: [smallItemLeft, smallItemRight]
        )
        horizontalGroup.contentInsets.top = 4

        let mainItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)
            )
        )
        mainItem.contentInsets.bottom = 4

        let verticalGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1)
        )
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: verticalGroupSize,
            subitems: [mainItem, horizontalGroup]
        )
        verticalGroup.contentInsets.leading = 4

        let leftItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
        )
        leftItem.contentInsets.trailing = 4

        let mainHorizontalGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1)
        )
        let mainHorizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: mainHorizontalGroupSize,
            subitems: [leftItem, verticalGroup]
        )

        let section = NSCollectionLayoutSection(group: mainHorizontalGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        section.interGroupSpacing = 8

        return .init(section: section)
    }
}
