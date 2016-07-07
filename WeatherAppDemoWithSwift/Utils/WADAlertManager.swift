//
//  WADAlertManager.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 4/07/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//

import Foundation
import UIKit

struct WADAlertManager {
    private static let cannotGetLocationMessage = "Sorry, we couldn't get your current location"
    private static let cannotGetWeatherInfoMessage = "Couldn't get the weather information, please check your network connection"
    
    private static func showAlert (message: String) {
        let alertController = UIAlertController(title: "Alert", message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    static func showLocationIsNotAvailableAlert () {
        showAlert(cannotGetLocationMessage)
    }
    
    static func showWeatherInfoIsNotAvailableAlert () {
        showAlert(cannotGetWeatherInfoMessage)
    }
}