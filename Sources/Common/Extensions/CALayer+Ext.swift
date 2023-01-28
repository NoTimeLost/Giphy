//
//  CALayer+Ext.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 27.01.2023.
//

import UIKit

extension CALayer {

    func makeGradient() {
        let backgroundColor: CGColor = .getRandomGradientColor()
        let highlightColor = UIColor.white.cgColor

        let skeletonLayer = CALayer()
        let gradientLayer = CAGradientLayer()

        skeletonLayer.backgroundColor = backgroundColor
        skeletonLayer.name = AnimationConstant.skeletonLayer
        skeletonLayer.anchorPoint = .zero
        skeletonLayer.frame.size = UIScreen.main.bounds.size

        gradientLayer.colors = [backgroundColor, highlightColor, backgroundColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.name = AnimationConstant.skeletonGradient
        
        mask = skeletonLayer
        addSublayer(skeletonLayer)
        addSublayer(gradientLayer)

        let width = UIScreen.main.bounds.width
        
        let animation = CABasicAnimation(keyPath: AnimationConstant.horizontalTransition)
        animation.duration = 3
        animation.fromValue = -width
        animation.toValue = width
        animation.repeatCount = .infinity
        animation.autoreverses = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        gradientLayer.add(animation, forKey: AnimationConstant.gradientShimmer)
    }
    
    func hideSkeleton() {
        sublayers?.removeAll {
            $0.name == AnimationConstant.skeletonLayer || $0.name == AnimationConstant.skeletonGradient
        }
    }
}
