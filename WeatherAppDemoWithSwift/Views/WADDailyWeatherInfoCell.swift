//
//  WADDailyWeatherInfoCell.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 5/07/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//

import Foundation
import UIKit

class WADDailyWeatherInfoCell: UITableViewCell {    
    @IBOutlet weak var dailyWeatherSummary: UILabel!
    @IBOutlet weak var dailyWeatherDate: UILabel!
    
    func setCellContent (date: String?, summary: String?) {
        dailyWeatherDate.text = date
        dailyWeatherSummary.text = summary
    }
}