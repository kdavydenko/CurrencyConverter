//
//  Currency.swift
//  Currency Converter
//
//  Created by KONSTANTIN DAVYDENKO on 2018-10-12.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

import Foundation

class Currency: Codable {
    
    let code: String
    let name: String
    let ratioToRub: Decimal
    
    init(code: String, name: String, ratioToRub: Decimal) {
        self.code = code
        self.name = name
        self.ratioToRub = ratioToRub
    }
}
