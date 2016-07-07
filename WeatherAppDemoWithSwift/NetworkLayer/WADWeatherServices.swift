//
//  WADWeatherServices.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 4/07/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//

import Foundation
import Alamofire

struct WADWeatherServices: WADNetworking {
    
    func getWeatherByLocationWithCompletion(location: Dictionary<String, Double>, response: Dictionary<String, AnyObject>? -> ()) {
        if location["latitude"] != nil && location["longitude"] != nil {
            let baseURL = "\(ServerAddress.address.rawValue)\(ServerAddress.apiKey.rawValue)/\(location["latitude"]!),\(location["longitude"]!)"
            self.getRequest(baseURL, params: nil, completionHandler: response)
        }
        else {
            WADAlertManager.showLocationIsNotAvailableAlert()
        }
    }
}

/**
 *  Using Alamofire as networking layer helper
 */
extension WADWeatherServices {
   
    private func baseRequest (baseURL: String, method: Alamofire.Method, params: Dictionary<String,AnyObject>?, completionHandler: ((response: Dictionary<String, AnyObject>?) -> Void)!) {
        
        Alamofire.request(method, baseURL, parameters: params, encoding: .JSON, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { (response: Response<AnyObject, NSError>) in
                
                if let value = response.result.value as? [String : AnyObject] {
                    completionHandler(response: value)
                }
                else {
                    completionHandler(response: nil)
                }
        }
    }
    
    private func getRequest (baseURL: String, params: Dictionary<String,AnyObject>?, completionHandler: ((response: Dictionary<String, AnyObject>?) -> Void)!) {
        baseRequest(baseURL, method: .GET, params: params, completionHandler: completionHandler)
    }
}