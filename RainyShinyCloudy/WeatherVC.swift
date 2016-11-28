//
//  WeatherVC.swift
//  RainyShinyCloudy
//
//  Created by Luis Ramirez on 11/26/16.
//  Copyright © 2016 Luis Ramirez. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var ForecastTableView: UITableView!
    @IBOutlet weak var todaysWeatherDescription: UILabel!
    @IBOutlet weak var todaysWeatherImage: UIImageView!
    @IBOutlet weak var todaysCityLbl: UILabel!
    @IBOutlet weak var todaysDateLbl: UILabel!
    @IBOutlet weak var todaysWeatherLbl: UILabel!
    
    var forecasts = [ForecastModel]()
    var locationManager = CLLocationManager()
    var currentWeather: CurrentWeather!
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        ForecastTableView.dataSource = self
        ForecastTableView.delegate = self
        
        
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        currentWeather = CurrentWeather()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
        
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadingWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                    
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = ForecastTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ForecastCell {
        
        let forecast = forecasts[indexPath.row]
        cell.configureCell(forecast: forecast)
        return cell
    } else {
            return ForecastCell()
    }
}

func downloadForecastData(completed: @escaping DownloadComplete) {
    
    let forecastURL = URL(string: forecastURLString)!
    Alamofire.request(forecastURL).responseJSON { (response) in
        let result = response.result
        
        if let dict = result.value as? Dictionary<String, AnyObject> {
            
            if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                
                for obj in list {
                    let forecast = ForecastModel(weatherDict: obj)
                    self.forecasts.append(forecast)
                    
                }
                self.forecasts.remove(at: 0)
                self.ForecastTableView.reloadData()
            }
            
        }
        completed()
    }
}


func updateMainUI() {
    todaysCityLbl.text = currentWeather.cityName
    todaysDateLbl.text = currentWeather.date
    todaysWeatherLbl.text = "\(currentWeather.currentTemp)"
    todaysWeatherImage.image = UIImage(named: currentWeather.weatherType)
    todaysWeatherDescription.text = currentWeather.weatherType
    
}




}

