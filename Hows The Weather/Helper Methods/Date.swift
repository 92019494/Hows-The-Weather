//
//  Date.swift
//  Hows The Weather
//
//  Created by Anthony on 13/02/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"

        let dateString = formatter.string(from: self)
        print(dateString)
        return dateString
    }
    
    
    func testToString() -> String {         
         
        // 1) Create a DateFormatter() object.
        let formatter = DateFormatter()
         
        // 2) Set the current timezone to .current, or America/Chicago.
        formatter.timeZone = .current
         
        // 3) Set the format of the altered date.
        formatter.dateFormat = "h:mm a"
        //formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
         
        // 4) Set the current date, altered by timezone.
        let dateString = formatter.string(from: self)
        print(dateString)
        return dateString
    }
    
    func getDayAsString() -> String {
         let day = Calendar.current.dateComponents([.weekday], from: self).weekday
        if day != nil {
            switch day! {
            case 1:
                return "Sunday"
            case 2:
                return "Monday"
            case 3:
                return "Tuesday"
            case 4:
                return "Wednesday"
            case 5:
                return "Thursday"
            case 6:
                return "Friday"
            case 7:
                return "Saturday"
            default:
                break
            }
        }
        return "Unable to retrieve day"
    }
    
   

}
