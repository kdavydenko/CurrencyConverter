//
//  CurrencyConverterRouter.swift
//  Currency Converter
//
//  Created by kdavydenko on 13/10/2018.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

import UIKit

protocol CurrencyConverterRouterProtocol: class {
    func closeCurrentViewController()
    func openCurrenciesList(with currencies: [Currency], sender:CurrencyPickerSelectionProtocol)
}

class CurrencyConverterRouter: CurrencyConverterRouterProtocol {
    
    weak var viewController: CurrencyConverterViewController!
    
    init(viewController: CurrencyConverterViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func openCurrenciesList(with currencies: [Currency], sender:CurrencyPickerSelectionProtocol) {
        DispatchQueue.main.async {
            let currencyPickerViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "CurrencyPickerViewController") as! CurrencyPickerViewController
            UIApplication.shared.keyWindow?.rootViewController?.present(currencyPickerViewController, animated: true, completion:nil)
            let currencyPickerConfigurator = CurrencyPickerConfigurator()
            currencyPickerConfigurator.configure(with: currencyPickerViewController, sender:sender, currencies: currencies)
        }
    }
}
