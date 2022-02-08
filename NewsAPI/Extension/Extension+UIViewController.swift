//
//  Extension+UIViewController.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 03/02/22.
//

import UIKit.UIViewController

extension UIViewController {
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
