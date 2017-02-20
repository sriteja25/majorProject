//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Caleb Stultz on 7/28/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    fileprivate init() {}
    
    var latitude: Double!
    var longitude: Double!
}
