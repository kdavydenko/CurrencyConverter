//
//  CurrencyLoaderRouter.swift
//  Currency Converter
//
//  Created by kdavydenko on 12/10/2018.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

import UIKit

protocol CurrencyLoaderRouterProtocol: class {
    func closeCurrentViewController()
    func showCurrencyConverterScene()
}

class CurrencyLoaderRouter: CurrencyLoaderRouterProtocol {
    
    weak var viewController: CurrencyLoaderViewController!
    
    init(viewController: CurrencyLoaderViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func showCurrencyConverterScene() {
        DispatchQueue.main.async {
            let currencyConverterViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "CurrencyConverterViewController") as! CurrencyConverterViewController
            let currencyConverterConfigurator = CurrencyConverterConfigurator()
            currencyConverterConfigurator.configure(with: currencyConverterViewController)
            UIApplication.shared.keyWindow?.rootViewController = currencyConverterViewController
        }
    }
}
