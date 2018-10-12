//
//  CurrencyConverterViewController.swift
//  Currency Converter
//
//  Created by kdavydenko on 13/10/2018.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

import UIKit

protocol CurrencyConverterViewProtocol: class {
    func setFirstCurrencyButtonText(_ text: String)
    func setFirstCurrencyValue(_ value: String)
    func setSecondCurrencyButtonText(_ text: String)
    func setSecondCurrencyValue(_ value: String)
}

class CurrencyConverterViewController: UIViewController, CurrencyConverterViewProtocol {

    @IBOutlet weak var firstCurrencyTextField: UITextField!
    @IBOutlet weak var firstCurrencyButton: UIButton!
    @IBOutlet weak var secondCurrencyTextField: UITextField!
    @IBOutlet weak var secondCurrencyButton: UIButton!
    
    var presenter: CurrencyConverterPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setFirstCurrencyButtonText(_ text: String) {
        DispatchQueue.main.async {
            self.firstCurrencyButton.setTitle(text, for: .normal)
        }
    }
    
    func setFirstCurrencyValue(_ value: String) {
        DispatchQueue.main.async {
            self.firstCurrencyTextField.text = value
        }
    }
    
    func setSecondCurrencyButtonText(_ text: String) {
        DispatchQueue.main.async {
            self.secondCurrencyButton.setTitle(text, for: .normal)
        }
    }
    
    func setSecondCurrencyValue(_ value: String) {
        DispatchQueue.main.async {
            self.secondCurrencyTextField.text = value
        }
    }
    
    @IBAction func firstCurrencyButtonTapped(_ sender: UIButton) {
        presenter.firstCurrencyButtonTapped()
    }
    
    @IBAction func secondCurrencyButtonTapped(_ sender: UIButton) {
        presenter.secondCurrencyButtonTapped()
    }
    
}

extension CurrencyConverterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (range.length + range.location > textField.text?.count ?? 0) {
            return false;
        }
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.,")
        if string.rangeOfCharacter(from: allowedCharacters.inverted) != nil {
            return false
        }
        var updatedText = string
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            updatedText = text.replacingCharacters(in: textRange, with: string)
        }
        
        if textField == self.firstCurrencyTextField {
            presenter.firstValueChanged(to: updatedText)
            return true
        } else if textField == self.secondCurrencyTextField {
            presenter.secondValueChanged(to: updatedText)
            return true
        }
        return false
    }
}
