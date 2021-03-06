//
//  AppConstants.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/8.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

enum AppConstants {
    static let baseURL = "https://api.foursquare.com/v2/"
    static let clientId = "C0APJW4F1MIJHC3IOFNF5BZFCKBHWOPGPQOO0XWRFBNOROJJ"
    static let clientSecret = "2JJQF13S10ERG1NVOQZZZX5PPHJWKVPIS4KPGWFY13SN4QET"
    static let envoyOfficeCoordinates = "37.775299,-122.398064"
}

public enum Spacing {
    public static let zero: CGFloat = 0
    public static let four: CGFloat = 4
    public static let eight: CGFloat = 8
    public static let twelve: CGFloat = 12
    public static let sixteen: CGFloat = 16
    public static let twentyFour: CGFloat = 24
    public static let thirtyTwo: CGFloat = 32
    public static let fortyEight: CGFloat = 48
    public static let sixty: CGFloat = 60
}

public enum RequestConfig {
    public static let venuesPerPage = 10
}
