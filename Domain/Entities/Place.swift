//
//  Place.swift
//  Domain
//
//  Created by Ashkan Ghaderi on 2022-02-03.
//

import Foundation

// MARK: - Place
public struct Place: Codable {
    public var fsqID: String?
    public var categories: [Category]?
    public var chains: [Chain]?
    public var distance: Int?
    public var geocodes: Geocodes?
    public var location: Location?
    public var name: String?
    public var relatedPlaces: RelatedPlaces?
    public var timezone: String?

    enum CodingKeys: String, CodingKey {
        case fsqID = "fsq_id"
        case categories, chains, distance, geocodes, location, name
        case relatedPlaces = "related_places"
        case timezone
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fsqID = try values.decodeIfPresent(String.self, forKey: .fsqID)
        categories = try values.decodeIfPresent([Category].self, forKey: .categories)
        chains = try values.decodeIfPresent([Chain].self, forKey: .chains)
        distance = try values.decodeIfPresent(Int.self, forKey: .distance)
        geocodes = try values.decodeIfPresent(Geocodes.self, forKey: .geocodes)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        relatedPlaces = try values.decodeIfPresent(RelatedPlaces.self, forKey: .relatedPlaces)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
    }
    
    public init() {}
}

// MARK: - Category
public struct Category: Codable {
    public let id: Int
    public let name: String
    public let icon: Icon
}

// MARK: - Icon
public struct Icon: Codable {
    public let iconPrefix: String
    public let suffix: String

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

// MARK: - Chain
public struct Chain: Codable {
    public let id, name: String
}

// MARK: - Geocodes
public struct Geocodes: Codable {
    public let frontDoor: FrontDoor?
    public let main: FrontDoor

    enum CodingKeys: String, CodingKey {
        case frontDoor = "front_door"
        case main
    }
}

// MARK: - FrontDoor
public struct FrontDoor: Codable {
    public let latitude, longitude: Double
}

// MARK: - Location
public struct Location: Codable {
    public let address: String?
    public let country: String?
    public let crossStreet: String?
    public let dma, locality: String?
    public let neighborhood: [String]?
    public let postcode: String?
    public let region: String?
    public let addressExtended: String?

    enum CodingKeys: String, CodingKey {
        case address, country
        case crossStreet = "cross_street"
        case dma, locality, neighborhood, postcode, region
        case addressExtended = "address_extended"
    }
}

// MARK: - RelatedPlaces
public struct RelatedPlaces: Codable {
    public let children: [Parent]?
    public let parent: Parent?
}

// MARK: - Parent
public struct Parent: Codable {
    public let fsqID, name: String

    enum CodingKeys: String, CodingKey {
        case fsqID = "fsq_id"
        case name
    }
}
