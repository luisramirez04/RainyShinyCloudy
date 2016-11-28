//
//  ForecastCell.swift
//  RainyShinyCloudy
//
//  Created by Luis Ramirez on 11/26/16.
//  Copyright © 2016 Luis Ramirez. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet weak var forecastLow: UILabel!
    @IBOutlet weak var forecastHigh: UILabel!
    @IBOutlet weak var forecastDescription: UILabel!
    @IBOutlet weak var forecastDate: UILabel!
    @IBOutlet weak var forecastImage: UIImageView!
    
    func configureCell(forecast: ForecastModel) {
        forecastLow.text = "\(forecast.lowTemp)"
        forecastHigh.text = "\(forecast.highTemp)"
        forecastDescription.text = forecast.weatherType
        forecastImage.image = UIImage(named: forecast.weatherType)
        forecastDate.text = forecast.date
    }


}
