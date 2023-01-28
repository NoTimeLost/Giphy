//
//  UICollectionView+Ext.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 27.01.2023.
//

import UIKit

extension UICollectionView {

    func register<CellType: UICollectionViewCell>(_ cellType: CellType.Type) {
        register(cellType, forCellWithReuseIdentifier: CellType.identifier)
    }
    
    func dequeueReusableCell<CellType: UICollectionViewCell>(for indexPath: IndexPath) -> CellType {
        dequeueReusableCell(withReuseIdentifier: CellType.identifier, for: indexPath) as? CellType ?? .init()
    }
}
