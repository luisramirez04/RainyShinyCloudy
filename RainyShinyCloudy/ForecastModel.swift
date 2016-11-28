//
//  ForecastModel.swift
//  RainyShinyCloudy
//
//  Created by Luis Ramirez on 11/26/16.
//  Copyright © 2016 Luis Ramirez. All rights reserved.
//

import Foundation
import Alamofire

class ForecastModel {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        
        return _lowTemp
    }
    
    func kelvinToFarenheit(kelvinTemp: Double) -> Double {
        
        let kelvinToFarenheitPreDivision = (kelvinTemp * (9/5) - 459.67)
        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
        
        return kelvinToFarenheit
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let min = temp["min"] as? Double {
                
                self._lowTemp = "\(kelvinToFarenheit(kelvinTemp: min))"
                print(self._lowTemp)
            }
            
            if let max = temp["max"] as? Double {
                
                self._highTemp = "\(kelvinToFarenheit(kelvinTemp: max))"
                print(self._highTemp)
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let mainWeather = weather[0]["main"] as? String {
                self._weatherType = mainWeather
                print(self._weatherType)
            }
            
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
        
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
}
