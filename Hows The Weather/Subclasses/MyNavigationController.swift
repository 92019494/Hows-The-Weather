//
//  MyNavigationController.swift
//  Super Simple Calorie Counter
//
//  Created by Anthony on 31/01/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let navBar =  self.navigationBar
        navBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Constants.futuraBoldFont, size: 20.0), NSAttributedString.Key.foregroundColor: Constants.titleColor]
        navBar.barTintColor = UIColor.white
//        navBar.setBackgroundImage(UIImage(), for: .default)
//        navBar.shadowImage = UIImage()
//        navBar.isTranslucent = true
        
        
    }

    
}
