//
//  Bundle.swift
//  Traveller
//
//  Created by Anthony on 9/01/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// func to load view from nib file
    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }
        fatalError("Could not load view with type " + String(describing: type))
    }
    
}
