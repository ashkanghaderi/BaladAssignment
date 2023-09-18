//
//  PlaceQueryProvider.swift
//  Domain
//
//  Created by Ashkan Ghaderi on 2022-02-03.
//

import Foundation

public typealias VoidCompletion = ((Result<(), Error>) -> Void)

public protocol PlaceQueriesProtocol {
    
    func save(primaryKey: String,
              with place: Place,
              completion: VoidCompletion?)
    
    func fetchAllPlaces() throws -> [Place]
}
