//
//  MainPageViewController.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 4/07/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//

import Foundation
import UIKit

class WADMainPageViewController: UIViewController {
    
    @IBOutlet weak var forcastingTable: UITableView!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var currentWeatherSummary: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    
    // Services from Swinject Configuration
    var mainPageViewModel: WADViewModel?
    var loadingSpinner: WADLoadingIndicator?
    
    var weatherDailyDataList = [] {
        didSet {
            self.forcastingTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         *  Apply autolayout constraints to tableview cell
         *  Don't implement "heightForRowAtIndexPath" delegate method in order to make it
         */
        self.forcastingTable.rowHeight = UITableViewAutomaticDimension
        self.forcastingTable.estimatedRowHeight = 80
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        /**
         *    Getting user current location as well as weather information for the region user being in
         */
        self.loadingSpinner?.showHUDinView(self.view)
        mainPageViewModel?.getCurrentLocation()
        
        mainPageViewModel?.dataSavingCompleted = { [unowned self] in
            self.loadingSpinner?.hideHUDinView(self.view)
            self.weatherDailyDataList = DailyWeatherData.getDailyWeatherDataList()
            self.currentDate.text = CurrentWeatherData.getCurrentWeatherDate()
            self.currentWeatherSummary.text = CurrentWeatherData.getCurrentWeatherSummary()
            self.currentTemperature.text = String(format: "%.f°", CurrentWeatherData.getCurrentWeatherTemperature())
        }
    }
}

extension WADMainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDailyDataList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("DailyInfoCell", forIndexPath: indexPath) as? WADDailyWeatherInfoCell
        if cell == nil {
            cell = WADDailyWeatherInfoCell()
        }
        
        let dailyWeatherData = self.weatherDailyDataList[indexPath.row] as! DailyWeatherData
        cell!.setCellContent(DailyWeatherData.getDailyWeatherDateString(dailyWeatherData.dailyWeatherDate), summary: dailyWeatherData.dailyWeatherSummary)
        return cell!
    }
}