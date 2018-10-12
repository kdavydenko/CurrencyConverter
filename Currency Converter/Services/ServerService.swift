//
//  ServerService.swift
//  Currency Converter
//
//  Created by KONSTANTIN DAVYDENKO on 2018-10-13.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

import Foundation

protocol ServerServiceProtocol: class {
    var urlCurrenciesSource: String { get }
    func getCurrenciesData(completion: @escaping (Data?, Error?) -> ())
}

class ServerService: ServerServiceProtocol {
    var urlCurrenciesSource: String {
        return "https://www.cbr.ru/scripts/XML_daily.asp"
    }
    
    func getCurrenciesData(completion: @escaping (Data?, Error?) -> ()) {
        let urlSession = URLSession.shared
        
        let dataTask = urlSession.dataTask(with: URL(string: urlCurrenciesSource)!) { (data, response, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            
            if let data = data {
                completion(data, nil)
            }
        }
        dataTask.resume()
    }
}
