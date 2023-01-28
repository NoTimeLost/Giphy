//
//  GifCell.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 27.01.2023.
//

import UIKit
import Kingfisher

final class GifCell: UICollectionViewCell {

    // MARK: - UI

    private let gifImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        gifImageView.layer.makeGradient()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        gifImageView.image = nil
        gifImageView.layer.makeGradient()
    }

    // MARK: - public functions

    func configure(with model: Model) {
        guard let url = URL(string: model.imageUrl) else { return }

        gifImageView.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ],
            completionHandler: { [weak self] _ in
                self?.gifImageView.layer.hideSkeleton()
            }
        )
    }
}

// MARK: - Private functions

private extension GifCell {

    func setupUI() {
        contentView.addSubview(gifImageView)
        NSLayoutConstraint.activate([
            gifImageView.topAnchor.constraint(equalTo: topAnchor),
            gifImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gifImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gifImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
