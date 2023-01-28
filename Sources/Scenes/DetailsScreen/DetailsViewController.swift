//
//  DetailsViewController.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 28.01.2023.
//

import UIKit
import Kingfisher

final class DetailsViewController: UIViewController {

    // MARK: - Private properties

    private var gifUrl: String?

    // MARK: - UI

    private let gifImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private let copyGifButton: UIButton = {
        let button = UIButton()
        button.setTitle("Copy gif url", for: .normal)
        button.backgroundColor = .purple
        button.tintColor = .white
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setupConstraints()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - DetailsViewControllerDelegate

extension DetailsViewController: DetailsViewControllerDelegate {

    func didSelectGif(with url: String) {
        gifUrl = url
        gifImageView.kf.setImage(
            with: URL(string: url),
            placeholder: nil,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(Constant.animationDuration)),
                .cacheOriginalImage
            ],
            completionHandler: { [weak self] _ in
                guard let self = self else { return }

                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.view.layer.hideSkeleton()
            }
        )
    }
}

// MARK: - Private functions

private extension DetailsViewController {

    func addSubviews() {
        view.addSubview(gifImageView)
        view.addSubview(copyGifButton)
    }

    func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareButtonTap)
        )
        navigationItem.rightBarButtonItem?.isEnabled = false

        copyGifButton.addTarget(self, action: #selector(copyLinkButtonTap), for: .touchUpInside)

        view.layer.makeGradient()
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
    }

    func setupConstraints() {
        let basePadding = LayoutConstant.basePadding
        let verticalPadding = Constant.verticalPadding

        NSLayoutConstraint.activate([
            copyGifButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -verticalPadding),
            copyGifButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -basePadding),
            copyGifButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: basePadding),
            copyGifButton.heightAnchor.constraint(equalToConstant: verticalPadding),

            gifImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: verticalPadding),
            gifImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -basePadding),
            gifImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: basePadding),
            gifImageView.bottomAnchor.constraint(equalTo: copyGifButton.topAnchor, constant: -basePadding / 2)
        ])
    }

    @objc func shareButtonTap() {
        guard
            let image = gifImageView.image,
            let url = gifUrl
        else {
            return
        }

        let activityViewController = UIActivityViewController(
            activityItems: [url, image],
            applicationActivities: nil
        )

        present(activityViewController, animated: true)
    }

    @objc func copyLinkButtonTap() {
        UIPasteboard.general.string = gifUrl
        copyGifButton.setTitle("Copied", for: .normal)
    }
}

// MARK: - Constant

private extension DetailsViewController {

    enum Constant {
        static let verticalPadding: CGFloat = 50
        static let animationDuration = 0.5
    }
}
