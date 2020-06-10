//
//  Envoy_CoffeeWebServiceTests.swift
//  
//
//  Created by Antonio Chan on 2020/6/10.
//

import XCTest
@testable import Envoy_Coffee

class WebServiceTests: XCTestCase {
    var homeViewController: HomeViewController!
    var mockWebService: WebService!

    override func setUp() {
        super.setUp()
        mockWebService = WebService()
        homeViewController = HomeViewController(webService: mockWebService)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchDataCalled() {
        homeViewController.getVenueList()
        XCTAssertTrue(mockWebService.fetchDataWasCalled)
    }
}
