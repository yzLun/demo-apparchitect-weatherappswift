//
//  WADLocationServiceHelper.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 4/07/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//

import Foundation
import CoreLocation

class WADLocationServiceHelper: NSObject, WADLocation {
    var locationManager: CLLocationManager!
    var locationUpdateCompleted: ((Double, Double) -> ())?
    
    func startGettingCurrentLocation() {
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        self.locationManager.distanceFilter = 10;
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension WADLocationServiceHelper: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        WADAlertManager.showLocationIsNotAvailableAlert()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        self.locationManager.stopUpdatingLocation()
        
        if self.locationUpdateCompleted != nil {
            self.locationUpdateCompleted!(newLocation.coordinate.latitude, newLocation.coordinate.longitude)
        }
    }
}