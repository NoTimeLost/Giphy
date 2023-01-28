//
//  FeedScreenRouter.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 28.01.2023.
//

import UIKit

final class FeedScreenRouter: FeedScreenRoutingLogic {

    // MARK: - DetailsViewControllerDelegate

    weak var detailsViewControllerDelegate: DetailsViewControllerDelegate?

    // MARK: - FeedScreenDisplayLogic

    weak var controller: UIViewController?

    func navigateToDetailsController(with gifUrl: String) {
        let detailsVC = DetailsViewController()

        detailsViewControllerDelegate = detailsVC
        detailsViewControllerDelegate?.didSelectGif(with: gifUrl)

        controller?.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
