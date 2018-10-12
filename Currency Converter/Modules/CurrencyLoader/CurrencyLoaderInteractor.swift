//
//  CurrencyLoaderInteractor.swift
//  Currency Converter
//
//  Created by kdavydenko on 12/10/2018.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

protocol CurrencyLoaderInteractorProtocol: class {
    func getCurrencies()
}

class CurrencyLoaderInteractor: CurrencyLoaderInteractorProtocol {
    
    weak var presenter: CurrencyLoaderPresenterProtocol!
    
    let currencyService: CurrencyServiceProtocol = CurrencyService.shared
    
    required init(presenter: CurrencyLoaderPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getCurrencies() {
        presenter.showHUD()
        currencyService.getCurrencies { (success) in
            if success {
                self.presenter.hideHUD()
                self.presenter.currenciesLoaded()
            } else {
                self.presenter.hideHUD()
                self.presenter.showErrorMessageAndTryAgainButton()
            }
        }
    }

}
