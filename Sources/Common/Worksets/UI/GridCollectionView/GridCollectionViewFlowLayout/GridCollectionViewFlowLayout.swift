//
//  GridCollectionViewFlowLayout.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 27.01.2023.
//

import UIKit

final class GridCollectionViewFlowLayout: UICollectionViewFlowLayout {

    // MARK: - GridCollectionViewFlowLayoutDelegate

    weak var delegate: GridCollectionViewFlowLayoutDelegate?

    // MARK: - Private properties

    private let distance: CGFloat
    private let numberOfColumns: Int
    private var contentHeight: CGFloat
    private var cache: [UICollectionViewLayoutAttributes]

    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return .zero }
        
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    // MARK: - Initialization

   init(
    distance: CGFloat = 2,
    numberOfColumns: Int = 2,
    cache: [UICollectionViewLayoutAttributes] = [],
    contentHeight: CGFloat = .zero
   ) {
       self.distance = distance
       self.numberOfColumns = numberOfColumns
       self.contentHeight = contentHeight
       self.cache = cache

       super.init()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collectionViewContentSize: CGSize {
        CGSize(width: contentWidth, height: contentHeight)
    }

    // MARK: - Lifecycle

    override func prepare() {
        guard let collectionView = collectionView else { return }

        cache.removeAll()

        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        let xOffset = (.zero ..< numberOfColumns).map { CGFloat($0) * columnWidth }

        var column = 0
        var yOffset = Array(repeating: CGFloat.zero, count: numberOfColumns)

        let items = (.zero ..< collectionView.numberOfItems(inSection: .zero))

        items.forEach {
            let indexPath = IndexPath(item: $0, section: .zero)
    
            let gifHeight = delegate?.collectionView(collectionView, heightForCellAtIndexPath: indexPath) ?? 180
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: gifHeight)
            let insetFrame = frame.insetBy(dx: distance, dy: distance)
    
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
    
            cache.append(attributes)
            contentHeight = max(contentHeight, frame.maxY)

            yOffset[column] += gifHeight
            column = (column + 1) % numberOfColumns
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        cache.filter { $0.frame.intersects(rect) }
    }
}
