//
//  HomeViewModelTests.swift
//  Envoy-CoffeeTests
//
//  Created by Antonio Chan on 2020/6/10.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import XCTest
@testable import Envoy_Coffee

class HomeViewModelTests: XCTestCase {
    var mockViewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        self.mockViewModel = HomeViewModel(venueList: VenueList(response: VenueListResponse(headerFullLocation: "Test Full Location",
                                                                                            totalResults: 50,
                                                                                            groups: [VenueListGroups(items: [ItemObject(venue: Venue(id: "123",
                                                                                                                                                     name: "Test Venue",
                                                                                                                                                     location: VenueLocation(formattedAddress: [], distance: 500),
                                                                                                                                                     stats: nil,
                                                                                                                                                     price: nil,
                                                                                                                                                     rating: nil,
                                                                                                                                                     ratingSignals: nil))])])),
                                           limit: 10,
                                           venuePhotoResponse: [],
                                           filterConfigurations: FilterConfigurations(clientID: "testclientidkey",
                                                                                      clientSecret: "testclientSecretkey",
                                                                                      sectionQuery: "coffee",
                                                                                      radius: nil))
    }
    
    func testPhotoRequestURL() {
        XCTAssertEqual(mockViewModel.photoRequestURL(venueId: "123"), AppConstants.baseURL + "venues/123" + "/photos?client_id=" + AppConstants.clientId + "&client_secret=" + AppConstants.clientSecret + "&v=20200608")
    }
    
    func testVenueIds() {
        XCTAssertEqual(mockViewModel.venuIds, ["123"])
    }
    
    func testMaxRoundedValue() {
        XCTAssertEqual(mockViewModel.maxRoundedValue, 50)
    }
    
    func testMainRequestURLWithMock() {
        XCTAssertEqual(mockViewModel.mainRequestURL, AppConstants.baseURL + "venues/explore?client_id=testclientidkey&client_secret=testclientSecretkey&ll=" + AppConstants.envoyOfficeCoordinates + "&section=coffee&v=20200608&limit=10")
    }
    
    func testMainRequestURLWithRadius() {
        mockViewModel.filterConfigurations = FilterConfigurations(clientID: "testclientidkey",
                                                                  clientSecret: "testclientSecretkey",
                                                                  sectionQuery: "coffee",
                                                                  radius: 500)
        XCTAssertEqual(mockViewModel.mainRequestURL, AppConstants.baseURL + "venues/explore?client_id=testclientidkey&client_secret=testclientSecretkey&ll=" + AppConstants.envoyOfficeCoordinates + "&section=coffee&radius=500&v=20200608&limit=10")
    }

}
