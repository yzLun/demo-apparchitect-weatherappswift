//
//  MainPageViewModel.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 4/07/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//

import Foundation

class WADMainPageViewModel: WADViewModel {
    var weatherServices: WADNetworking?
    var locationManager: WADLocation?
    var dataSavingCompleted: (() -> ())?
    var locationCoordinates: Dictionary<String, Double> = [:] {
        didSet {
            /**
             * Call weather service if current location has been detected
             */
            self.getCurrentWeatherData()
        }
    }
    
    init (networkService: WADNetworking, locationService: WADLocation) {
        self.weatherServices = networkService
        self.locationManager = locationService
        
    }
    
    func getCurrentWeatherData() {
        weatherServices?.getWeatherByLocationWithCompletion(self.locationCoordinates) { (response: Dictionary<String, AnyObject>?) in
            if response != nil {
                /**
                 *    Nested saving current weather data and daily weather data
                 */
                CurrentWeatherData.saveCurrentWeatherData(response, completion: { (success: Bool, error: NSError?) in
                    let daily = response!["daily"] as! Dictionary<String,AnyObject>
                    let dailyDataList = daily["data"] as! Array<AnyObject>
                    DailyWeatherData.saveDailyWeatherData(dailyDataList, completion: { [unowned self] (success: Bool, error: NSError?) in
                        if self.dataSavingCompleted != nil && error == nil { self.dataSavingCompleted!() }
                    })
                })
            }
            else {
                WADAlertManager.showWeatherInfoIsNotAvailableAlert()
            }
        }
    }
    
    func getCurrentLocation() {
        locationManager?.startGettingCurrentLocation()
        locationManager?.locationUpdateCompleted = { [unowned self] (latitude: Double, longtitude: Double) in
            self.locationCoordinates = ["latitude" : latitude, "longitude" : longtitude]
        }
    }
}