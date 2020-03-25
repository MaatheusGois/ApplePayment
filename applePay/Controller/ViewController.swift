//
//  ViewController.swift
//  applePay
//
//  Created by Matheus Silva on 25/03/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import UIKit
import PassKit


class ViewController: UIViewController {
    
    /// Data **Setup**
    var shoeData: Shoes {
        return Shoe.shoesExample()
    }
    
    // Storyboard outlets
    @IBOutlet weak var shoePickerView: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    
    // Set up variables
    lazy var applePayment = ApplePayment(viewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoePickerView.delegate = self
        shoePickerView.dataSource = self
    }
    
    //MARK: - Actions
    @IBAction func buyShoeTapped(_ sender: UIButton) {
        let selectedIndex = shoePickerView.selectedRow(inComponent: 0)
        let shoe = shoeData[selectedIndex]
        applePayment.callPayment(shoe: shoe)
    }
}


extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: - Pickerview update
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shoeData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            let priceString = String(format: "%.02f", shoeData[row].price)
            priceLabel.text = "Preço = R$\(priceString)"
        }
        return shoeData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let priceString = String(format: "%.02f", shoeData[row].price)
        priceLabel.text = "Preço = R$\(priceString)"
    }
}
