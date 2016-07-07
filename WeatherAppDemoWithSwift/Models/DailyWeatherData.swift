//
//  DailyWeatherData.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 5/07/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//

import Foundation
import CoreData
import MagicalRecord

class DailyWeatherData: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    class func saveDailyWeatherData (response: Array<AnyObject>, completion: (Bool, NSError?) -> ()) {
        MagicalRecord.saveWithBlock({ (localContext: NSManagedObjectContext!) in
            self.MR_truncateAllInContext(localContext)
            self.MR_importFromArray(response as! [[NSObject : AnyObject]], inContext: localContext)
            }, completion: completion)
    }
    
    class func getDailyWeatherDataList () -> Array<AnyObject> {
        return self.MR_findAllSortedBy("dailyWeatherDate", ascending: true)!
    }
    
    class func getDailyWeatherDateString (dailyWeatherDate: NSDate?) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        return dailyWeatherDate == nil ? "" : dateFormatter.stringFromDate(dailyWeatherDate!)
    }
}
