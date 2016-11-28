//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by Luis Ramirez on 11/26/16.
//  Copyright © 2016 Luis Ramirez. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APIKEY = ""

let todaysURLString = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APIKEY)"

typealias DownloadComplete = () -> ()


let FORECAST_BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let FORECAST_LATITUTE = "lat="
let FORECAST_LONGITUDE = "&lon="
let FORECAST_APIKEY = "&cnt=10&mode=json&appid="

let forecastURLString = "\(FORECAST_BASE_URL)\(FORECAST_LATITUTE)\(Location.sharedInstance.latitude!)\(FORECAST_LONGITUDE)\(Location.sharedInstance.longitude!)\(FORECAST_APIKEY)"



