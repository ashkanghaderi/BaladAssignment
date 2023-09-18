//
//  AppErrors.swift
//  Domain
//
//  Created by Ashkan Ghaderi on 2022-02-03.
//

import Foundation

public enum AppErrors: Error {
    case errorMessage(_ message: String)
    case shouldBeRunOnMainThread
}
