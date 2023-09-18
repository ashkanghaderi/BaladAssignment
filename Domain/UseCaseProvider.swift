//
//  UseCaseProvider.swift
//  Domain
//
//  Created by Ashkan Ghaderi on 2022-02-03.
//

import Foundation

public protocol UseCaseProvider {
    
    func makePlaceUseCase() -> PlaceUseCase
}
