//
//  CurrentWeather.swift
//  RainyShinyCloudy
//
//  Created by Luis Ramirez on 11/26/16.
//  Copyright © 2016 Luis Ramirez. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class CurrentWeather {
 
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0
        }
        return _currentTemp
    }
    
    func downloadingWeatherDetails(completed: @escaping DownloadComplete) {
        
        let currentWeatherURL = URL(string: todaysURLString)!
        Alamofire.request(currentWeatherURL).responseJSON { (response) in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let weatherMain = weather[0]["main"] as? String {
                        self._weatherType = weatherMain
                        print(self._weatherType)
                    }
                    
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let currentTemperature = main["temp"] as? Double {
                        
                        let kelvinToFarenheitPreDivision = (currentTemperature * (9/5) - 459.67)
                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                        self._currentTemp = kelvinToFarenheit
                        
                    }
                    
                
                }
                
            }
            completed()
        }
       
        
    }
    
}
