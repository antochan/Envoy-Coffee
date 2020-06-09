//
//  Venue.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/8.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import Foundation

struct Venue: Codable {
    let id: String
    let name: String
    let location: VenueLocation?
    let stats: VenueStats?
    let price: VenuePrice?
}

struct VenueLocation: Codable {
    /// Array of formatted address of venue
    let formattedAddress: [String]?
    /// Distance in meters
    let distance: Int?
}

struct VenueStats: Codable {
    let tipCount: Int?
    let usersCount: Int?
    let checkinsCount: Int?
}

struct VenuePrice: Codable {
    /// Scale out of 3, 1 being cheap and 3 being expensive
    let tier: Int
    let message: String
    let currency: String
}
