//
//  PlaceServices.swift
//  Data
//
//  Created by Ashkan Ghaderi on 2022-02-03.
//

import Foundation
import Domain
import RxSwift

public final class PlaceService {
    
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    public func fetchAllPlaces(lat:Double,lng:Double) -> Observable<[Place]>{
        let url = ServiceRouter.PlaceServiceRoute(.places).url
        let query = "?ll=\(lat),\(lng)"
        return network.getItems(url,itemId: query)
    }
}
