//
//  DefaultPlace.swift
//  Data
//
//  Created by Ashkan Ghaderi on 2022-02-03.
//

import Foundation
import CoreStore
import Domain

public class DefaultPlace: CoreStoreObject {
    
    @Field.Stored("primaryKey", dynamicInitialValue: {""})
    public var primaryKey: String
    
    @Field.Coded("Place", coder: FieldCoders.Json.self, dynamicInitialValue: { Place() } )
    public var place: Place
    
    public typealias UniqueIDType = String
    var uniqueIDValue: UniqueIDType {
        get { return primaryKey }
    }
}

