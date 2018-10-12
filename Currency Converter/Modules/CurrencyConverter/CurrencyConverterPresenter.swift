//
//  CurrencyConverterPresenter.swift
//  Currency Converter
//
//  Created by kdavydenko on 13/10/2018.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

protocol CurrencyConverterPresenterProtocol: class {
    var router: CurrencyConverterRouterProtocol! { set get }
    func configureView()
    func firstValueChanged(to value: String?)
    func secondValueChanged(to value: String?)
    func firstCurrencyButtonTapped()
    func secondCurrencyButtonTapped()
}

class CurrencyConverterPresenter: CurrencyConverterPresenterProtocol, CurrencyPickerSelectionProtocol {
    
    weak var view: CurrencyConverterViewProtocol!
    var interactor: CurrencyConverterInteractorProtocol!
    var router: CurrencyConverterRouterProtocol!
    
    required init(view: CurrencyConverterViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        setButtonsText()
    }
    
    func setButtonsText() {
        view.setFirstCurrencyButtonText(interactor.firstCurrency.code)
        view.setSecondCurrencyButtonText(interactor.secondCurrency.code)
    }
    
    func firstValueChanged(to value: String?) {
        if let value = value, value.count > 0 {
            updateSecondValue(with: interactor.getSecondValue(with: value))
        } else {
            updateSecondValue(with: "")
        }
    }
    
    func secondValueChanged(to value: String?) {
        if let value = value, value.count > 0 {
            updateFirstValue(with: interactor.getFirstValue(with: value))
        } else {
            updateFirstValue(with: "")
        }
    }
    
    func updateFirstValue(with string: String) {
        view.setFirstCurrencyValue(string)
    }
    
    func updateSecondValue(with string: String) {
        view.setSecondCurrencyValue(string)
    }
    
    func firstCurrencyButtonTapped() {
        interactor.firstCurrencyChanging()
        router.openCurrenciesList(with: interactor.getCurrenciesListForPicker(), sender: self)
    }
    
    func secondCurrencyButtonTapped() {
        interactor.secondCurrencyChanging()
        router.openCurrenciesList(with: interactor.getCurrenciesListForPicker(), sender: self)
    }
    
    func selectCurrency(with code: String) {
        interactor.setCurrency(with: code)
        setButtonsText()
    }
    
}
