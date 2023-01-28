//
//  FeedScreenAssembly.swift
//  Giphy
//
//  Created by Kozlov Vitaly on 27.01.2023.
//

enum FeedScreenAssembly {
    static func buildModule() -> FeedViewController {
        let service = GIPHYServiceImpl(networkService: NetworkServiceImpl())
        let presenter = FeedScreenPresenter(service: service)
        let router = FeedScreenRouter()
        let view = FeedViewController(presenter: presenter, router: router)

        presenter.view = view
        router.controller = view

        return view
    }
}
