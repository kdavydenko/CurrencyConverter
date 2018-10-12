//
//  CurrencyLoaderConfigurator.swift
//  Currency Converter
//
//  Created by kdavydenko on 12/10/2018.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

protocol CurrencyLoaderConfiguratorProtocol: class {
    func configure(with viewController: CurrencyLoaderViewController)
}

class CurrencyLoaderConfigurator: CurrencyLoaderConfiguratorProtocol {

    func configure(with viewController: CurrencyLoaderViewController) {
        let presenter = CurrencyLoaderPresenter(view: viewController)
        let interactor = CurrencyLoaderInteractor(presenter: presenter)
        let router = CurrencyLoaderRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.configureView()
    }
}
