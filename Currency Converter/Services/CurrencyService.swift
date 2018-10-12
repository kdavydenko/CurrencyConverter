//
//  CurrencyService.swift
//  Currency Converter
//
//  Created by KONSTANTIN DAVYDENKO on 2018-10-13.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

import Foundation

struct CurrencyError : Error {
    let description : String
}

protocol CurrencyServiceProtocol: class {
    var currencies: [Currency]! { get set }
    func getCurrencies(completion: @escaping (Bool) -> ())
}

class CurrencyService: NSObject, CurrencyServiceProtocol, XMLParserDelegate {
    static let shared = CurrencyService()
    
    var currencies: [Currency]!
    let serverService: ServerServiceProtocol = ServerService()
    
    func getCurrencies(completion: @escaping (Bool) -> ()) {
        serverService.getCurrenciesData { (data, error) in
            if error != nil {
                completion(false)
                return
            }
            
            if let data = data {
                self.parseCurrencies(with: data, completion: { parsed in
                    if parsed {
                        completion(true)
                    } else {
                        completion(false)
                    }
                })
            }
        }
    }
    
    func parseCurrencies(with data: Data, completion: @escaping(Bool) -> ()) {
        let parser = XMLParser(data: data)
        parser.delegate = self
        if parser.parse() {
            if self.results?.isEmpty ?? true {
                completion(false)
            } else {
                let rub = Currency(code: "RUB", name: "Российский рубль", ratioToRub: Decimal(integerLiteral: 1))
                self.results?.append(rub)
                self.currencies = self.results!
                completion(true)
            }
        } else {
            completion(false)
        }
    }
    
    
    let recordKey = "Valute"
    let dictionaryKeys = ["CharCode", "Nominal", "Value", "Name"]
    var results: [Currency]? = [Currency]()
    var currentDictionary: [String: String]!
    var currentValue: String?
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == recordKey {
            self.currentDictionary = [String : String]()
        } else if dictionaryKeys.contains(elementName) {
            self.currentValue = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.currentValue? += string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == self.recordKey {
            if let code: String = self.currentDictionary["CharCode"],
                let name: String = self.currentDictionary["Name"],
                let ratioString: String = self.currentDictionary["Value"],
                let nominalString: String = self.currentDictionary["Nominal"],
                let ratio: Decimal = Decimal(string: ratioString.replacingOccurrences(of: ",", with: ".")),
                let nominal: Decimal = Decimal(string: nominalString) {
                let currency = Currency(code: code, name: name, ratioToRub: ratio / nominal)
                
                self.results?.append(currency)
            }
            self.currentDictionary = nil
        } else if dictionaryKeys.contains(elementName) {
            self.currentDictionary[elementName] = currentValue
            self.currentValue = nil
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
        self.currentValue = nil
        self.currentDictionary = nil
        self.results = nil
    }
}
