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
    var limit: Int = 10
    var venuePhotoResponse: [VenuePhotoResponse]
    
    static let defaultViewModel = HomeViewModel(venueList: VenueList(response: VenueListResponse(headerFullLocation: "",
                                                                                                 totalResults: 0,
                                                                                                 groups: [])
                                                                     ),
                                                venuePhotoResponse: []
    )
}

extension HomeViewModel {
    var mainRequestURL: String {
        return AppConstants.baseURL + "venues/explore?client_id=" + AppConstants.clientId + "&client_secret=" + AppConstants.clientSecret + "&ll=" + AppConstants.envoyOfficeCoordinates + "&section=coffee&v=20200608" + "&limit=\(limit)"
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
}
