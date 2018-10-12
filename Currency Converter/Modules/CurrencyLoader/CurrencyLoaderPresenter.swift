//
//  CurrencyLoaderPresenter.swift
//  Currency Converter
//
//  Created by kdavydenko on 12/10/2018.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

protocol CurrencyLoaderPresenterProtocol: class {
    var router: CurrencyLoaderRouterProtocol! { set get }
    func configureView()
    func showHUD()
    func hideHUD()
    func showErrorMessageAndTryAgainButton()
    func hideErrorMessageAndTryAgainButton()
    func tryAgainButtonTapped()
    func currenciesLoaded()
}

class CurrencyLoaderPresenter: CurrencyLoaderPresenterProtocol {
    
    weak var view: CurrencyLoaderViewProtocol!
    var interactor: CurrencyLoaderInteractorProtocol!
    var router: CurrencyLoaderRouterProtocol!
    
    required init(view: CurrencyLoaderViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        interactor.getCurrencies()
    }
    
    func showHUD() {
        view.showHUD()
    }
    
    func hideHUD() {
        view.hideHUD()
    }
    
    func showErrorMessageAndTryAgainButton() {
        view.showErrorMessageAndTryAgainButton()
    }
    
    func hideErrorMessageAndTryAgainButton() {
        view.hideErrorMessageAndTryAgainButton()
    }
    
    func tryAgainButtonTapped() {
        view.hideErrorMessageAndTryAgainButton()
        interactor.getCurrencies()
    }
    
    func currenciesLoaded() {
        view.hideHUD()
        router.showCurrencyConverterScene()
    }
}
