//
//  UIViewControllerExtension.swift
//  Test Project
//
//  Created by István Stefánovics on 2018. 05. 26..
//  Copyright © 2018. István Stefánovics. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
