//
//  CurrentWeatherData.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 5/07/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//

import Foundation
import CoreData
import MagicalRecord

class CurrentWeatherData: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    class func saveCurrentWeatherData (response: Dictionary<String, AnyObject>?, completion: (Bool, NSError?) -> ()) {
        MagicalRecord.saveWithBlock({ (localContext: NSManagedObjectContext!) in
            self.MR_truncateAllInContext(localContext)
            self.MR_importFromObject(response!["currently"]!, inContext: localContext)
            }, completion: completion)
    }
    
    class func getCurrentWeatherSummary () -> String {
        let item = self.MR_findFirst()
        if let weatherSummary = item?.weatherSummary {
            return weatherSummary
        }
        return ""
    }
    
    class func getCurrentWeatherDate () -> String {
        let item = self.MR_findFirst()
        let weatherDate: NSDate? = item?.weatherDate
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM HH:mm"
        return weatherDate != nil ? dateFormatter.stringFromDate(weatherDate!) : ""
    }
    
    class func getCurrentWeatherTemperature () -> Double {
        let item = self.MR_findFirst()
        if let weatherTemperature = item?.weatherTemperature {
            /**
             *    Convert Fahrenheit to Celsius
             */
            return (weatherTemperature.doubleValue-32)/1.8
        }
        return -999
    }
}
