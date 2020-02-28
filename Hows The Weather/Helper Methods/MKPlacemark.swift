//
//  MKPlacemark.swift
//  Traveller
//
//  Created by Anthony on 11/01/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//
import MapKit
import Contacts

extension MKPlacemark {
    
    /// returns a formatted address
    var formattedAddress: String? {
        guard let postalAddress = postalAddress else { return nil }
        return CNPostalAddressFormatter.string(from: postalAddress, style: .mailingAddress).replacingOccurrences(of: "\n", with: " ")
    }
}
