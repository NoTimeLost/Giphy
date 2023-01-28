//
//  FeedViewController.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 26.01.2023.
//

import UIKit

final class FeedViewController: UIViewController {

    // MARK: - DetailsViewControllerDelegate

    weak var detailsViewControllerDelegate: DetailsViewControllerDelegate?

    // MARK: - Private properties

    private let presenter: FeedScreenPresentationLogic & FeedPresenterState
    private let router: FeedScreenRoutingLogic

    // MARK: - UI

    private lazy var categoryCollectionView: HorizontalCollectionView = {
        let collectionView = HorizontalCollectionView()
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self)

        return collectionView
    }()

    private lazy var gifCollectionView: MosaicCollectionView = {
        let collectionView = MosaicCollectionView()
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GifCell.self)

        return collectionView
    }()

    // MARK: - Initialization

    init(presenter: FeedScreenPresentationLogic & FeedPresenterState, router: FeedScreenRoutingLogic) {
        self.presenter = presenter
        self.router = router

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        addSubviews()
        setupConstraints()
        presenter.loadData()
    }
}

// MARK: - FeedScreenDisplayLogic

extension FeedViewController: FeedScreenDisplayLogic {

    func reloadCategory() {
        categoryCollectionView.reloadData()
    }

    func reloadGif() {
        gifCollectionView.reloadData()
    }
}

// MARK: - Private functions

private extension FeedViewController {

    func addSubviews() {
        view.addSubview(categoryCollectionView)
        view.addSubview(gifCollectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 60),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            gifCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor),
            gifCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gifCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gifCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate

extension FeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case gifCollectionView:
            router.navigateToDetailsController(with: presenter.gifList[indexPath.row].images.original.url)
        case categoryCollectionView:
            presenter.updateCategory(for: indexPath)
            gifCollectionView.setContentOffset(.zero, animated: true)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch collectionView {
        case gifCollectionView:
            presenter.updateGifCollection(for: indexPath)
        case categoryCollectionView:
            presenter.updateCategoryCollection(for: indexPath)
        default:
            break
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FeedViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case gifCollectionView:
            return presenter.gifList.count
        case categoryCollectionView:
            return presenter.categories.count
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case gifCollectionView:
            let cell: GifCell = collectionView.dequeueReusableCell(for: indexPath)

            cell.configure(with: GifCell.Model(imageUrl: presenter.gifList[indexPath.row].images.previewGif.url))
            return cell
        case categoryCollectionView:
            let cell: CategoryCell = collectionView.dequeueReusableCell(for: indexPath)

            cell.configure(with: CategoryCell.Model(name: presenter.categories[indexPath.row].name))
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
