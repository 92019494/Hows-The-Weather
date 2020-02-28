//
//  CLLocation.swift
//  Traveller
//
//  Created by Anthony on 2/01/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    
    /// returns a string of the distance between locations in kms
    func getDistanceString(latitude: Double, longitude: Double) -> String {
        var distanceInKilometres: Double = 0
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        let distance = self.distance(from: location)
        if distance >= 1000 {
            distanceInKilometres = distance / 1000
            return String(format: "%.0fkm from current location",distanceInKilometres)
        }
        else {
            return String(format: "%.0fm from current location",distance)
        }
    }
    
    /// returns a string of the distance between locations in kms
    func getDistance(latitude: Double, longitude: Double) -> Double {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let distance = self.distance(from: location)
        return distance
    }
    
    /// checks if a location is within a search radius
    func isWithinSearchRadius(latitude: Double, longitude: Double, searchRadius: Int) -> Bool {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let distance = self.distance(from: location) / 1000
        if Int(distance) < searchRadius {
            return true
        }
        return false
    }
    
}
