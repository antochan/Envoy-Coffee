//
//  HomeViewModel.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/8.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import Foundation

struct FilterConfigurations {
    let clientID: String
    let clientSecret: String
    let sectionQuery: String
    let radius: Int?
    
    static let defaultFilterConfiguration = FilterConfigurations(clientID: AppConstants.clientId,
                                                                 clientSecret: AppConstants.clientSecret,
                                                                 sectionQuery: "coffee",
                                                                 radius: nil)
}

struct HomeViewModel {
    var venueList: VenueList
    var limit: Int = RequestConfig.venuesPerPage
    var venuePhotoResponse: [VenuePhotoResponse]
    var filterConfigurations: FilterConfigurations
    
    static let defaultViewModel = HomeViewModel(venueList: VenueList(response: VenueListResponse(headerFullLocation: "",
                                                                                                 totalResults: 0,
                                                                                                 groups: [])
                                                                     ),
                                                venuePhotoResponse: [],
                                                filterConfigurations: FilterConfigurations.defaultFilterConfiguration
    )
}

extension HomeViewModel {
    var mainRequestURL: String {
        var radiusURLQuery = ""
        if let radius = filterConfigurations.radius {
            radiusURLQuery = "&radius=\(radius)"
        }
        return AppConstants.baseURL + "venues/explore?client_id=" + filterConfigurations.clientID + "&client_secret=" + filterConfigurations.clientSecret + "&ll=" + AppConstants.envoyOfficeCoordinates + "&section=" + filterConfigurations.sectionQuery + radiusURLQuery + "&v=20200608" + "&limit=\(limit)"
    }
    
    func photoRequestURL(venueId: String) -> String {
        return AppConstants.baseURL + "venues/" + venueId + "/photos?client_id=" + AppConstants.clientId + "&client_secret=" + AppConstants.clientSecret + "&v=20200608"
    }
    
    var firstGroup: [ItemObject] {
        guard let first = venueList.response.groups.first else { return [] }
        return first.items
    }
    
    var venuIds: [String] {
        var ids = [String]()
        firstGroup.forEach {
            ids.append($0.venue.id)
        }
        return ids
    }
    
    var venuePhotoImageURLs: [String] {
        var imageURLs = [String]()
        venuePhotoResponse.forEach {
            if let photoDetails = $0.response.photos?.items.first {
                let constructedURL = photoDetails.prefix + "110x160" + photoDetails.suffix
                imageURLs.append(constructedURL)
            } else {
                imageURLs.append("")
            }
        }
        return imageURLs
    }
    
    var maxRoundedValue: Int {
        return venueList.response.totalResults.rounding(nearest: RequestConfig.venuesPerPage)
    }
}
