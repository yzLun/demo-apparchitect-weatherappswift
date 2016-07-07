//
//  WADConstants.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 29/06/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//

import Foundation

struct WADWeatherServer {
    static let addressURL = "https://api.forecast.io/forecast/"
    static let apiKey = "1f1ce1b3170863d1e54ebf90d025f91d"
}

enum ServerAddress: String {
    case address = "https://api.forecast.io/forecast/"
    case apiKey = "1f1ce1b3170863d1e54ebf90d025f91d"
}