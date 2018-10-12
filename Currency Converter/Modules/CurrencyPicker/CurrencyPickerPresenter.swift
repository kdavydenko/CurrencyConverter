//
//  CurrencyPickerPresenter.swift
//  Currency Converter
//
//  Created by kdavydenko on 14/10/2018.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

protocol CurrencyPickerSelectionProtocol {
    func selectCurrency(with code: String)
}

protocol CurrencyPickerPresenterProtocol: class {
    var router: CurrencyPickerRouterProtocol! { set get }
    func configureView()
    func currencySelected(with code: String)
    func cancelButtonTapped()
}

class CurrencyPickerPresenter: CurrencyPickerPresenterProtocol {
    
    weak var view: CurrencyPickerViewProtocol!
    var interactor: CurrencyPickerInteractorProtocol!
    var router: CurrencyPickerRouterProtocol!
    var delegate: CurrencyPickerSelectionProtocol!
    
    required init(view: CurrencyPickerViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        view.updateCurrencies(interactor.currencies)
    }
    
    func currencySelected(with code: String) {
        delegate.selectCurrency(with: code)
        router.closeCurrentViewController()
    }
    
    func cancelButtonTapped() {
        router.closeCurrentViewController()
    }
}
