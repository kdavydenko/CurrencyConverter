//
//  CurrencyPickerViewController.swift
//  Currency Converter
//
//  Created by kdavydenko on 14/10/2018.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

import UIKit

protocol CurrencyPickerViewProtocol: class {
    func updateCurrencies(_ currencies: [Currency])
}

class CurrencyPickerViewController: UIViewController, CurrencyPickerViewProtocol {

    var presenter: CurrencyPickerPresenterProtocol!
    
    var currencies = [Currency]()

    @IBOutlet weak var currenciesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateCurrencies(_ currencies: [Currency]) {
        self.currencies = currencies
        currenciesTableView.reloadData()
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        presenter.cancelButtonTapped()
    }
}

extension CurrencyPickerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as! CurrencyTableViewCell
        cell.currencyName.text = currencies[indexPath.row].name
        cell.currencyCode.text = currencies[indexPath.row].code
        cell.accessoryType = .none
        return cell
    }
}

extension CurrencyPickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.currencySelected(with: currencies[indexPath.row].code)
    }
}
