//
//  UseCaseProvider.swift
//  Data
//
//  Created by Ashkan Ghaderi on 2022-02-03.
//

import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider
{
    public init() {}
    
    public func makePlaceUseCase() -> Domain.PlaceUseCase {
        return PlaceUseCase()
    }

}
