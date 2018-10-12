//
//  CurrencyPickerConfigurator.swift
//  Currency Converter
//
//  Created by kdavydenko on 14/10/2018.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

protocol CurrencyPickerConfiguratorProtocol: class {
    func configure(with viewController: CurrencyPickerViewController, sender:CurrencyPickerSelectionProtocol, currencies: [Currency])
}

class CurrencyPickerConfigurator: CurrencyPickerConfiguratorProtocol {

    func configure(with viewController: CurrencyPickerViewController, sender:CurrencyPickerSelectionProtocol, currencies: [Currency]) {
        let presenter = CurrencyPickerPresenter(view: viewController)
        let interactor = CurrencyPickerInteractor(presenter: presenter)
        let router = CurrencyPickerRouter(viewController: viewController)
        
        viewController.presenter = presenter
        interactor.currencies = currencies
        presenter.delegate = sender
        presenter.interactor = interactor
        presenter.router = router
        presenter.configureView()
    }
}
