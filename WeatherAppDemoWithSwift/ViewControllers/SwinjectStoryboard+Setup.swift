//
//  SwinjectStoryboard+Setup.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 4/07/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//

import Foundation
import Swinject

extension SwinjectStoryboard {
    class func setup() {
        
        print("Swinject Setup")
        
        defaultContainer.registerForStoryboard(WADMainPageViewController.self) { r, c in
            c.mainPageViewModel = r.resolve(WADViewModel.self)
            c.loadingSpinner = r.resolve(WADLoadingIndicator.self)
        }
        defaultContainer.register(WADViewModel.self) { r in
            WADMainPageViewModel(networkService: r.resolve(WADNetworking.self)! , locationService: r.resolve(WADLocation.self)!)
        }
        defaultContainer.register(WADLoadingIndicator.self) { _ in WADSpinner() }
        
        defaultContainer.register(WADNetworking.self) { _ in WADWeatherServices() }
        defaultContainer.register(WADLocation.self) { _ in WADLocationServiceHelper() }
    }
    
}
