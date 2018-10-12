//
//  CurrencyPickerRouter.swift
//  Currency Converter
//
//  Created by kdavydenko on 14/10/2018.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

protocol CurrencyPickerRouterProtocol: class {
    func closeCurrentViewController()
}

class CurrencyPickerRouter: CurrencyPickerRouterProtocol {
    
    weak var viewController: CurrencyPickerViewController!
    
    init(viewController: CurrencyPickerViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
