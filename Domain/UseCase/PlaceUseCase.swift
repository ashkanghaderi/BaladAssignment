//
//  PlaceUseCase.swift
//  Domain
//
//  Created by Ashkan Ghaderi on 2022-02-03.
//

import Foundation
import RxSwift

public protocol PlaceUseCase {
    func fetchPlaces(lat:Double,lng:Double) -> Observable<[Place]>
}
