//
//  GridCollectionViewFlowLayoutDelegate.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 27.01.2023.
//

import UIKit

protocol GridCollectionViewFlowLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForCellAtIndexPath indexPath: IndexPath) -> CGFloat
}
