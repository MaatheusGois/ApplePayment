//
//  Payment.swift
//  applePay
//
//  Created by Matheus Silva on 25/03/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation
import PassKit


class ApplePayment: NSObject {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func callPayment(shoe: Shoe) {
        let paymentItem = PKPaymentSummaryItem.init(label: shoe.name, amount: NSDecimalNumber(value: shoe.price))
        
        /**
         Set types of payments acepts
         */
        let paymentNetworks = [PKPaymentNetwork.amex, .discover, .masterCard, .visa]
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) {
            let request = PKPaymentRequest()
            /** establish the currency and country code — you can change these to fit your app.
             */
            request.currencyCode = "BRL"
            request.countryCode = "BR"
            /** verifies your merchant ID. Make sure to change line 3 and input the name of the merchant ID you created.
             */
            request.merchantIdentifier = "merchant.pet"
            /** checks the type of transaction. **PKMerchantCapability.capability3DS** uses the 3-D Secure protocol, a secure way of processing debit and credit cards.
             */
            request.merchantCapabilities = PKMerchantCapability.capability3DS
            
            /**
             This is only the basic information; you can add more information in the request, such as the billing information, shipping methods, and supported countries.
             */
            request.supportedNetworks = paymentNetworks
            request.paymentSummaryItems = [paymentItem]
            
            ///Validate if the dispositive acepet
            if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) {
                guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request) else {
                    self.viewController?.displayDefaultAlert(title: "Error", message: "Unable to present Apple Pay authorization.")
                    return
                }
                paymentVC.delegate = self
                self.viewController?.present(paymentVC, animated: true, completion: nil)
            }
        } else {
            self.viewController?.displayDefaultAlert(title: "Error", message: "Unable to make Apple Pay transaction.")
        }
    }
    
}


extension ApplePayment: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        viewController?.dismiss(animated: true, completion: nil)
        
    }
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        viewController?.dismiss(animated: true, completion: nil)
        viewController?.displayDefaultAlert(title: "Success!", message: "The Apple Pay transaction was complete.")
    }
}
