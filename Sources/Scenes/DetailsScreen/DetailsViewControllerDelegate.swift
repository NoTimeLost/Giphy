//
//  DetailsViewControllerDelegate.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 28.01.2023.
//

protocol DetailsViewControllerDelegate: AnyObject {
    func didSelectGif(with url: String)
}
