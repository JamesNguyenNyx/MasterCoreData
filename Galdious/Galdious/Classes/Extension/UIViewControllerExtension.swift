//
//  UIViewControllerExtension.swift
//  Galdious
//
//  Created by James Nguyen on 2017/08/21.
//  Copyright © 2017 James Nguyen. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(message: String) {
        showAlert(message: message, andTitle: "")
    }
    
    func showAlert(message: String, andTitle title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AlertView.AlertButtonTitle.save.rawValue, style: .default, handler: nil ))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(message: String) {
        showAlert(message: message, andTitle: AlertView.AlertTitle.error.rawValue)
    }
}
