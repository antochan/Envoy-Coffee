//
//  VenuePhoto.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/9.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

struct VenuePhotoResponse: Codable {
    let response: VenuePhotos
}

struct VenuePhotos: Codable {
    let photos: VenuePhotoDetails?
}

struct VenuePhotoDetails: Codable {
    let count: Int
    let items: [Photo]
}

struct Photo: Codable {
    let id: String
    let prefix: String
    let suffix: String
}
