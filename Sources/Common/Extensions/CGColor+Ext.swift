//
//  CGColor+Ext.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 27.01.2023.
//

import UIKit

extension CGColor {

    static func getRandomGradientColor() -> CGColor {
        let gradientColors: [UIColor] = [.purple, .systemPink, .green]

        return gradientColors.randomElement()?.cgColor ?? CGColor(gray: .zero, alpha: .zero)
    }
}
