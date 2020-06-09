//
//  VenueList.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/8.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import Foundation

struct VenueList: Codable {
    let response: VenueListResponse
}

struct VenueListResponse: Codable {
    let headerFullLocation: String
    let totalResults: Int
    let groups: [VenueListGroups]
}

struct VenueListGroups: Codable {
    let items: [ItemObject]
}

struct ItemObject: Codable {
    let venue: Venue
}
