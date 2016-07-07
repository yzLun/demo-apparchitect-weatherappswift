//
//  NetworkServiceTest.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 6/07/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//

import XCTest
@testable import WeatherAppDemoWithSwift

class NetworkServicesTest: XCTestCase {

    var weatherServices: WADNetworking?
    let mockLocation = ["latitude" : -33.881361, "longitude" : 151.214544]
    let timeout = 10.0
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.weatherServices = WADWeatherServices()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func test_weatherService_create_properly () {
        XCTAssertNotNil(self.weatherServices, "Network service is not created properly")
    }
    
    func test_getWeatherInfomation_correctly () {
        let completionExpectation: XCTestExpectation = self.expectationWithDescription("Async services")
        self.weatherServices?.getWeatherByLocationWithCompletion(self.mockLocation, response: { (response: Dictionary<String, AnyObject>?) in
            XCTAssertNotNil(response, "Weather infomation can't be rechieved")
            completionExpectation.fulfill()
        })
        self.waitForExpectationsWithTimeout(self.timeout, handler: nil)
    }
    
    func test_WeatherInfomationIncludesCurrentData () {
        let completionExpectation: XCTestExpectation = self.expectationWithDescription("Async services")
        self.weatherServices?.getWeatherByLocationWithCompletion(self.mockLocation, response: { (response: Dictionary<String, AnyObject>?) in
            XCTAssertNotNil(response!["currently"], "Currently weather data wwasn't captured properly")
            completionExpectation.fulfill()
        })
        self.waitForExpectationsWithTimeout(self.timeout, handler: nil)
    }
    
    func test_WeatherInfomationIncludesDailyDataList () {
        let completionExpectation: XCTestExpectation = self.expectationWithDescription("Async services")
        self.weatherServices?.getWeatherByLocationWithCompletion(self.mockLocation, response: { (response: Dictionary<String, AnyObject>?) in
            let dailyDataObject = response!["daily"] as! Dictionary<String,AnyObject>
            let dailyDataList = dailyDataObject["data"] as! Array<AnyObject>
            XCTAssert(dailyDataList.count > 0, "Daily weather data list wasn't captured properly")
            completionExpectation.fulfill()
        })
        self.waitForExpectationsWithTimeout(self.timeout, handler: nil)
    }
}
