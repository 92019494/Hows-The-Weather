//
//  UIButton.swift
//  Traveller
//
//  Created by Anthony on 27/12/19.
//  Copyright © 2019 EmeraldApps. All rights reserved.
//

import UIKit

extension UIButton {
    
    func preventRepeatedPresses(inNext seconds: Double = 1) {
        self.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            self.isUserInteractionEnabled = true
        }
    }
    
    /// easier way to set button insets
    func setEdgeInsets(spacing: CGFloat){
        self.contentEdgeInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
    
    func disable(){
        self.isUserInteractionEnabled = false
    }
    
    func enable(){
        self.isUserInteractionEnabled = true
    }
    
}
