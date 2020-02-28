//
//  UIView.swift
//  Traveller
//
//  Created by Anthony on 25/09/19.
//  Copyright © 2019 EmeraldApps. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func setUpBackgroundColour(){
        self.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    func setUpBackgroundGradient(){
        self.applyVerticalGradient(colorOne: UIColor(named: "Facebook") ?? UIColor.blue ,colorTwo: UIColor(named: "AppPrimary") ?? UIColor.blue)
    }
    
    func applyVerticalGradient(colorOne: UIColor, colorTwo: UIColor){
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        layer.colors = [colorOne.cgColor, colorTwo.cgColor]
        layer.locations = [0,1]
        layer.startPoint = CGPoint(x:0.5,y:0)
        layer.endPoint = CGPoint(x:0.5, y:1)
        self.layer.insertSublayer(layer, at: 0)
        
    }
    
    func applyHorizontalGradient(colorOne: UIColor, colorTwo: UIColor){
            
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        layer.colors = [colorOne.cgColor, colorTwo.cgColor]
        layer.locations = [0,1]
        layer.startPoint = CGPoint(x:0,y:0.5)
        layer.endPoint = CGPoint(x:1, y:0.5)
        self.layer.insertSublayer(layer, at: 0)
        
    }
    
    func addShadow(){
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}
