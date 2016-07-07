//
//  DataStorageTest.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 7/07/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//

import XCTest
@testable import WeatherAppDemoWithSwift

class DataStorageTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func getMockWeatherInfomationData () -> Dictionary<String, AnyObject> {
        // Reading json file from unit testing bundle
        let testBundle = NSBundle(forClass: self.dynamicType)
        let filePath = testBundle.pathForResource("weather", ofType: "json")
        
        do {
            if let path = filePath, data = NSData(contentsOfFile: path) {
                let response = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                return response as! Dictionary<String, AnyObject>
            }
        }
        catch {
            print("Error occured when reading json from bundle")
        }
        
        return [:]
    }

    func test_saveCurrentlyWeatherDataProperly () {
        let completionExpectation: XCTestExpectation = self.expectationWithDescription("Data saving in background thread")
        let response = self.getMockWeatherInfomationData()
        CurrentWeatherData.saveCurrentWeatherData(response) { (success: Bool, error: NSError?) in
            XCTAssert(success, "Currently weather data wasn't saved properly")
            completionExpectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func test_saveCurrentTemperatureCorrectly () {
        let currentTemperature = CurrentWeatherData.getCurrentWeatherTemperature()
        let expectedCurrentTemperature = (80.56 - 32)/1.8
        
        XCTAssertEqual(currentTemperature, expectedCurrentTemperature, "Current temperature wasn't saved correctly")
    }
    
    func test_saveCurrentSummaryCorrectly () {
        let currentSummary = CurrentWeatherData.getCurrentWeatherSummary()
        let expectedCurrentSummary = "Mostly Cloudy"
        
        XCTAssertEqual(currentSummary, expectedCurrentSummary, "Current summary wasn't saved correctly")
    }
    
    func test_saveDailyWeatherDataProperly () {
        let completionExpectation: XCTestExpectation = self.expectationWithDescription("Data saving in background thread")
        let response = self.getMockWeatherInfomationData()
        let daily = response["daily"] as! Dictionary<String,AnyObject>
        let dailyDataList = daily["data"] as! Array<AnyObject>
        
        DailyWeatherData.saveDailyWeatherData(dailyDataList) { (success: Bool, error: NSError?) in
            XCTAssert(success, "Daily weather data wasn't saved properly")
            completionExpectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func test_convertDateCorrectly () {
        /// Choose the date: 2015-12-08 00:00:00
        let randomDate = NSDate(timeIntervalSince1970: 1449579600)
        let randomDateString = DailyWeatherData.getDailyWeatherDateString(randomDate)
        let expectedDateString = "09/12"
        
        XCTAssertEqual(randomDateString, expectedDateString, "Convert function didn't work correctly")
    }
    
    func test_saveDailyDateCorrectly () {
        let tomorrowWeatherForcasting = DailyWeatherData.getDailyWeatherDataList()[0] as! DailyWeatherData
        let dateOfTomorrow = DailyWeatherData.getDailyWeatherDateString(tomorrowWeatherForcasting.dailyWeatherDate)
        let expectedDateOfTomorrow = "08/12"
        
        XCTAssertEqual(dateOfTomorrow, expectedDateOfTomorrow, "Daily date wasn't saved correctly")
    }
    
    func test_saveDailySummaryCorrectly () {
        let tomorrowWeatherForcasting = DailyWeatherData.getDailyWeatherDataList()[0] as! DailyWeatherData
        let tomorrowSummary = tomorrowWeatherForcasting.dailyWeatherSummary
        let expectedTomorrowSummary = "Mostly cloudy throughout the day."
        
        XCTAssertEqual(tomorrowSummary, expectedTomorrowSummary, "Daily summary wasn't saved correctly")
    }
}
