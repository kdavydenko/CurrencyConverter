//
//  RootRouter.swift
//  Currency Converter
//
//  Created by KONSTANTIN DAVYDENKO on 2018-10-14.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

import UIKit

class RootRouter {
    class func openStartViewController(with window: UIWindow) {
        let currencyLoaderViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "CurrencyLoaderViewController")
        let currencyLoaderConfigurator = CurrencyLoaderConfigurator()
        currencyLoaderConfigurator.configure(with: currencyLoaderViewController as! CurrencyLoaderViewController)
        
        window.rootViewController = currencyLoaderViewController
        window.makeKeyAndVisible()
        
    }
}
