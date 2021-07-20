//
//  UIViewController+Alert.swift
//  FirstMemo
//
//  Created by Martin.Q on 2021/07/21.
//

import UIKit

extension UIViewController {
    func alert(title: String = "Alert", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Accept", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}
