//
//  CurrencyPickerInteractor.swift
//  Currency Converter
//
//  Created by kdavydenko on 14/10/2018.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

protocol CurrencyPickerInteractorProtocol: class {
    var currencies: [Currency]! { get set }
}

class CurrencyPickerInteractor: CurrencyPickerInteractorProtocol {

    weak var presenter: CurrencyPickerPresenterProtocol!
    
    var currencies: [Currency]!
    
    required init(presenter: CurrencyPickerPresenterProtocol) {
        self.presenter = presenter
    }
}
