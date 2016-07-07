//
//  LocationServicesTest.swift
//  WeatherAppDemoWithSwift
//
//  Created by yunzhi lun on 7/07/2016.
//  Copyright © 2016 yunzhi lun. All rights reserved.
//

import XCTest
import Swinject
@testable import WeatherAppDemoWithSwift

class LocationServicesTest: XCTestCase {

    var locationManager: WADLocation?
    var container: Container!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // Registration for the location manager
        self.container = Container()
        container.register(WADLocation.self) { _ in WADLocationServiceHelper()}
        self.locationManager = container.resolve(WADLocation.self)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_LocationServiceCreatedProperly () {
        XCTAssertNotNil(self.locationManager, "Location manager wasn't created properly")
    }
    
    func coordinatesIsMatched (locationOne: (Double, Double), locationTwo: (Double, Double)) -> Bool {
        return locationOne.0 == locationTwo.0 && locationOne.1 == locationTwo.1
    }
    
    func test_LocationCapturedCorrectly () {
        // Simulate location of Sydney
        let sydneyLatitude = -33.8634
        let sydneyLongitude = 151.211
        
        self.locationManager?.startGettingCurrentLocation()
        
        let completionExpectation: XCTestExpectation = self.expectationWithDescription("Location services update")
        self.locationManager?.locationUpdateCompleted = { (latitude: Double, longitude: Double) in
            XCTAssertTrue(self.coordinatesIsMatched((sydneyLatitude, sydneyLongitude), locationTwo: (latitude, longitude)), "Current location is not as expected")
            completionExpectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(10, handler: nil)
    }
    
}
