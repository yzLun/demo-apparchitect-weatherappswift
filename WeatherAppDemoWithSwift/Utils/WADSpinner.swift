//
//  WADSpinner.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 6/07/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

struct WADSpinner: WADLoadingIndicator {
    
    func showHUDinView (view: UIView) {
        MBProgressHUD.showHUDAddedTo(view, animated: true)
    }
    
    func hideHUDinView (view: UIView) {
        MBProgressHUD.hideHUDForView(view, animated: true)
    }
}
