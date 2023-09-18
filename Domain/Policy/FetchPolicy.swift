//
//  FetchPolicy.swift
//  Domain
//
//  Created by Ashkan Ghaderi on 2022-02-03.
//

import Foundation

public final class fetchPolicy {
    
    public static var share = fetchPolicy()
    
    public var shouldFetchPlacesFromServer: Bool = false
}
