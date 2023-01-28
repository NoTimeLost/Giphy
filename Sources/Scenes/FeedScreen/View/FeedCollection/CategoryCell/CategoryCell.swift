//
//  CategoryCell.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 27.01.2023.
//

import UIKit

final class CategoryCell: UICollectionViewCell {

    // MARK: - UI

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    // MARK: - Public properties

    override var isSelected: Bool {
        didSet {
            if isSelected { animateSelection() }
        }
    }

    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        categoryLabel.text = ""
    }

    // MARK: - public functions

    func configure(with model: Model) {
        categoryLabel.text = model.name.capitalized
    }
    
}

// MARK: - Private functions

private extension CategoryCell {

    func addSubviews() {
        contentView.addSubview(roundedView)
        roundedView.addSubview(categoryLabel)
    }
    
    func setupConstraints() {
        let padding = LayoutConstant.basePadding

        NSLayoutConstraint.activate([
            roundedView.topAnchor.constraint(equalTo: contentView.topAnchor),
            roundedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            roundedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            roundedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 5),
            categoryLabel.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -5),
            categoryLabel.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -padding),
            categoryLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: padding)
        ])

        roundedView.layoutIfNeeded()
    }
    
    func animateSelection() {
        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .linear)

        animator.addAnimations {
            self.roundedView.alpha = 0.5
        }
        animator.addAnimations({
            self.roundedView.alpha = 1
        }, delayFactor: 0.2)

        animator.startAnimation()
    }
}
