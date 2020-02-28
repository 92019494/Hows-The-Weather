//
//  Double.swift
//  Hows The Weather
//
//  Created by Anthony on 13/02/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import Foundation

extension Double {
    
    func getString() -> String {
        return String(format: "%.0f", self.rounded(.down))
    }
}
