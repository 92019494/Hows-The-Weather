//
//  Constants.swift
//  Hows The Weather
//
//  Created by Anthony on 11/02/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    
    // User Default Keys
    static let citiesKey = "cities"
    
    // Open Weather Map API Key
    //static let apiKey = "eea1fc31e9c640358a961c4039d3cadd"
    
    // Weather Bit API Key
    static let apiKey = "d1897b72d2b9429db21d9274431ceee2"
    
    // Colors
    static let primaryColor = UIColor(named: "Primary") ?? UIColor.black
    static let secondaryColor = UIColor(named: "Secondary") ?? UIColor.black
    static let supportingColor = UIColor(named: "Supporting") ?? UIColor.black
    static let titleColor = UIColor(named: "Title") ?? UIColor.black
    
    
    
    // Fonts
    static let avenirFont = "Avenir"
    static let futuraFont = "Futura"
    static let futuraBoldFont = "Futura-Bold"
    
    // NotificationNames
    static let foregroundNotificationName = UIApplication.willEnterForegroundNotification
}
