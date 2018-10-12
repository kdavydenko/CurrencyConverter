//
//  CurrencyConverterConfigurator.swift
//  Currency Converter
//
//  Created by kdavydenko on 13/10/2018.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

protocol CurrencyConverterConfiguratorProtocol: class {
    func configure(with viewController: CurrencyConverterViewController)
}

class CurrencyConverterConfigurator: CurrencyConverterConfiguratorProtocol {
    
    func configure(with viewController: CurrencyConverterViewController) {
        let presenter = CurrencyConverterPresenter(view: viewController)
        let interactor = CurrencyConverterInteractor(presenter: presenter)
        let router = CurrencyConverterRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.configureView()
    }
}
