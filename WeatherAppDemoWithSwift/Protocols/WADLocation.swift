//
//  WADLocation.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 4/07/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//

import Foundation

protocol WADLocation {
    var locationUpdateCompleted: ((Double, Double) -> ())? { get set }
    
    func startGettingCurrentLocation ()
}