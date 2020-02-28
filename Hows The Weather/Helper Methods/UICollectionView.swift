//
//  UICollectionView.swift
//  Traveller
//
//  Created by Anthony on 22/01/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func addMessageLabel(message: String, fontSize: CGFloat ){
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor(named: "TitleGrey")
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Futura-Bold", size: fontSize)
        messageLabel.sizeToFit()
        backgroundView = messageLabel;
    }
}
