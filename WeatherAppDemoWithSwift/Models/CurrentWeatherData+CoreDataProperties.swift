//
//  CurrentWeatherData+CoreDataProperties.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 5/07/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CurrentWeatherData {

    @NSManaged var weatherSummary: String?
    @NSManaged var weatherDate: NSDate?
    @NSManaged var weatherTemperature: NSNumber?
    @NSManaged var currentWeatherDataID: NSNumber?

}
