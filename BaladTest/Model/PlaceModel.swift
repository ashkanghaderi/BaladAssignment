//
//  PlaceModel.swift
//  BaladTest
//
//  Created by Ashkan Ghaderi on 2022-02-04.
//

import Foundation
import Domain

public struct PlaceModel {
    public var fsqID: String?
    public var categories: [CategoryModel]?
    public var chains: [ChainModel]?
    public var distance: Int?
    public var geocodes: GeocodesModel?
    public var location: LocationModel?
    public var name: String?
    public var relatedPlaces: RelatedPlacesModel?
    public var timezone: String?

    public init(_ place: Domain.Place) {
        self.fsqID = place.fsqID
        self.categories = place.categories.map { $0.map { CategoryModel($0) } }
        self.chains = place.chains.map { $0.map { ChainModel($0) } }
        self.distance = place.distance
        if let geocode = place.geocodes {
            self.geocodes = GeocodesModel(geocode)
        } else {
            self.geocodes = nil
        }
        if let location = place.location {
            self.location = LocationModel(location)
        } else {
            self.location = nil
        }
        self.name = place.name
        if let related = place.relatedPlaces {
            self.relatedPlaces = RelatedPlacesModel(related)
        } else {
            self.relatedPlaces = nil
        }
        self.timezone = place.timezone
    }
}

// MARK: - Category
public struct CategoryModel {
    let id: Int
    let name: String
    let icon: IconModel
    
    public init(_ category: Domain.Category) {
        self.id = category.id
        self.name = category.name
        self.icon = IconModel(category.icon)
    }
}

// MARK: - Icon
public struct IconModel {
    let iconPrefix: String
    let suffix: String
    
    public init(_ icon: Domain.Icon) {
        self.iconPrefix = icon.iconPrefix
        self.suffix = icon.suffix
    }
}

// MARK: - Chain
public struct ChainModel {
    let id, name: String
    
    public init(_ chain: Domain.Chain) {
        self.id = chain.id
        self.name = chain.name
    }
}

// MARK: - Geocodes
public struct GeocodesModel {
    let frontDoor: FrontDoorModel?
    let main: FrontDoorModel
    
    public init(_ geocode: Domain.Geocodes) {
        if let frontDoor = geocode.frontDoor {
            self.frontDoor = FrontDoorModel(frontDoor)
        } else {
            self.frontDoor = nil
        }
        self.main = FrontDoorModel(geocode.main)
    }
}

// MARK: - FrontDoor
public struct FrontDoorModel {
    let latitude, longitude: Double
    
    public init(_ front: Domain.FrontDoor) {
        self.latitude = front.latitude
        self.longitude = front.longitude
    }
}

// MARK: - Location
public struct LocationModel{
    let address: String?
    let country: String?
    let crossStreet: String?
    let dma, locality: String?
    let neighborhood: [String]?
    let postcode: String?
    let region: String?
    let addressExtended: String?
    
    public init(_ location: Domain.Location) {
        self.address = location.address
        self.country = location.country
        self.crossStreet = location.crossStreet
        self.dma = location.dma
        self.locality = location.locality
        self.neighborhood = location.neighborhood
        self.postcode = location.postcode
        self.region = location.region
        self.addressExtended = location.addressExtended
    }
}

// MARK: - RelatedPlaces
public struct RelatedPlacesModel {
    let children: [ParentModel]?
    let parent: ParentModel?
    
    public init(_ related: Domain.RelatedPlaces) {
        self.children = related.children.map { $0.map { ParentModel($0) } }
        if let parent = related.parent {
            self.parent = ParentModel(parent)
        } else {
            self.parent = nil
        }
    }
}

// MARK: - Parent
public struct ParentModel {
    let fsqID, name: String
    
    public init(_ parent: Domain.Parent) {
        self.fsqID = parent.fsqID
        self.name = parent.name
    }
}
