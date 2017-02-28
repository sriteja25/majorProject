//
//  extenstions.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 28/02/17.
//  Copyright © 2017 Sriteja Chilakamarri. All rights reserved.
//

import Foundation

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
