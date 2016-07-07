//
//  WADLoadingIndicator.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 6/07/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//

import Foundation
import UIKit

protocol WADLoadingIndicator {
    func showHUDinView (view: UIView)
    func hideHUDinView (view: UIView)
}