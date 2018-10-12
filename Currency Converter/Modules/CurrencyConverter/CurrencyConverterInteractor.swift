//
//  CurrencyConverterInteractor.swift
//  Currency Converter
//
//  Created by kdavydenko on 13/10/2018.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

import Foundation

enum CurrencyChangingMode {
    case firstCurrencyChanging
    case secondCurrencyChanging
}

protocol CurrencyConverterInteractorProtocol: class {
    var firstCurrency: Currency { get set }
    var secondCurrency: Currency { get set }
    func getFirstValue(with value: String) -> String
    func getSecondValue(with value: String) -> String
    func firstCurrencyChanging()
    func secondCurrencyChanging()
    func setCurrency(with code: String)
    func getCurrenciesListForPicker() -> [Currency]
}

class CurrencyConverterInteractor: CurrencyConverterInteractorProtocol {

    weak var presenter: CurrencyConverterPresenterProtocol!
    
    let currencyService: CurrencyServiceProtocol = CurrencyService.shared
    
    var currencyChangingMode: CurrencyChangingMode!
    
    var firstCurrency: Currency
    var secondCurrency: Currency
    
    required init(presenter: CurrencyConverterPresenterProtocol) {
        self.presenter = presenter
        firstCurrency = currencyService.currencies.filter{ $0.code == "USD"}.first!
        secondCurrency = currencyService.currencies.filter{ $0.code == "RUB"}.first!
    }
    
    func getFirstValue(with value: String) -> String {
        let currenciesRatio = (secondCurrency.ratioToRub / firstCurrency.ratioToRub)
        let decimalValue = Decimal(string: value)!
        let convertedValue = decimalValue * currenciesRatio
        
        return getFormattedValue(with: convertedValue)
    }
    
    func getSecondValue(with value: String) -> String {
        let currenciesRatio = (firstCurrency.ratioToRub / secondCurrency.ratioToRub)
        let decimalValue = Decimal(string: value)!
        let convertedValue = decimalValue * currenciesRatio
        
        return getFormattedValue(with: convertedValue)
        
    }
    
    func getFormattedValue(with value: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter.string(from: value as NSDecimalNumber)!
    }
    
    func firstCurrencyChanging() {
        currencyChangingMode = .firstCurrencyChanging
    }
    
    func secondCurrencyChanging() {
        currencyChangingMode = .secondCurrencyChanging
    }
    
    func setCurrency(with code: String) {
        switch currencyChangingMode! {
        case .firstCurrencyChanging:
            firstCurrency = currencyService.currencies.filter{$0.code == code}.first!
        case .secondCurrencyChanging:
            secondCurrency = currencyService.currencies.filter{$0.code == code}.first!
        }
    }
    
    func getCurrenciesListForPicker() -> [Currency] {
        var currencies = currencyService.currencies!
        switch currencyChangingMode! {
        case .firstCurrencyChanging:
            currencies.remove(at: currencies.enumerated().filter{ $0.element.code == secondCurrency.code }.first!.offset)
            return currencies
        case .secondCurrencyChanging:
            currencies.remove(at: currencies.enumerated().filter{ $0.element.code == firstCurrency.code }.first!.offset)
            return currencies
        }
    }
}
