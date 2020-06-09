//
//  HomeViewModel.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/8.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import Foundation

struct HomeViewModel {
    var venueList: VenueList
    
    static let defaultViewModel = HomeViewModel(venueList: VenueList(response: VenueListResponse(headerFullLocation: "",
                                                                                                 totalResults: 0,
                                                                                                 groups: [])
        )
    )
}

extension HomeViewModel {
    var requestURLString: String {
        return AppConstants.baseURL + "venues/explore?client_id=" + AppConstants.clientId + "&client_secret=" + AppConstants.clientSecret + "&ll=" + AppConstants.envoyOfficeCoordinates + "&section=coffee&v=20200608"
    }
}
