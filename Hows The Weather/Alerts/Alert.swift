//
//  Alert.swift
//  Hows The Weather
//
//  Created by Anthony on 12/02/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
    static func showBasicAlert(vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
    
    static func presentLocationAlert(vc: UIViewController){
        let alertVC = UIAlertController(title: "Location Services Disabled", message: "Please change in settings to continue using the application", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Open Settings", style: .default) { (UIAlertAction) in
            alertVC.removeFromParent()
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        let action2 = UIAlertAction(title: "Dismiss", style: .cancel) { (UIAlertAction) in
            alertVC.removeFromParent()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                exit(1)
            }
        }
        alertVC.addAction(action1)
        alertVC.addAction(action2)
        vc.present(alertVC, animated: true, completion: nil)
    }
}
