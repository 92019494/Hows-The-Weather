//
//  MyTabBarController.swift
//  Super Simple Calorie Counter
//
//  Created by Anthony on 31/01/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont(name: Constants.avenirFont, size: 14.0), NSAttributedString.Key.foregroundColor: Constants.titleColor]
        let selectedAttributes = [NSAttributedString.Key.foregroundColor: Constants.primaryColor]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        appearance.setTitleTextAttributes(selectedAttributes as [NSAttributedString.Key : Any], for: .selected)
          
        let tabBar = self.tabBar
        tabBar.tintColor = Constants.primaryColor
        tabBar.shadowImage = UIImage()
    }

}
