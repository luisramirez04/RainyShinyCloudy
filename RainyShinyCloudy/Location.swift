//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by Luis Ramirez on 11/27/16.
//  Copyright © 2016 Luis Ramirez. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
