//
//  CurrencyLoaderViewController.swift
//  Currency Converter
//
//  Created by kdavydenko on 12/10/2018.
//  Copyright © 2018 KONSTANTIN DAVYDENKO. All rights reserved.
//

import UIKit

protocol CurrencyLoaderViewProtocol: class {
    func showHUD()
    func hideHUD()
    func showErrorMessageAndTryAgainButton()
    func hideErrorMessageAndTryAgainButton()
}

class CurrencyLoaderViewController: UIViewController, CurrencyLoaderViewProtocol {
    
    var presenter: CurrencyLoaderPresenterProtocol!

    @IBOutlet weak var hudView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showHUD() {
        DispatchQueue.main.async {
            self.hudView.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideHUD() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.hudView.isHidden = true
        }
    }
    
    func showErrorMessageAndTryAgainButton() {
        DispatchQueue.main.async {
            self.errorLabel.text = "Ошибка загрузки данных"
            self.errorLabel.isHidden = false
            self.tryAgainButton.setTitle("Перезагрузить", for: .normal)
            self.tryAgainButton.isHidden = false
        }
    }
    
    func hideErrorMessageAndTryAgainButton() {
        DispatchQueue.main.async {
            self.errorLabel.isHidden = true
            self.tryAgainButton.isHidden = true
        }
    }
    
    @IBAction func tryAgainButtonTapped(_ sender: Any) {
        presenter.tryAgainButtonTapped()
    }
}
