//
//  ServiceRouter.swift
//  Domain
//
//  Created by Ashkan Ghaderi on 2022-02-03.
//

import Foundation

public enum BaseURL: String {
    
    case dev = "https://api.foursquare.com/v3"
}

// MARK: - ServiceRouter Definition

public enum ServiceRouter {
    
    case PlaceServiceRoute(PlaceRoute)
}

extension ServiceRouter {
    public var url: String {
        switch self {
        case .PlaceServiceRoute(let placeRoute):
            return placeRoute.path
        }
 
    }
}


// MARK: - PlaceRoute

public enum PlaceRoute: String {
    
    case places = "/places/nearby"
    case placeDetail = "/places"
    
    var path: String {
        return  rawValue
    }
}
