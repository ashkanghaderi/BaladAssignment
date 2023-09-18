//
//  BaladError.swift
//  Domain
//
//  Created by Ashkan Ghaderi on 2022-02-03.
//

import Foundation

public enum BaladError: LocalizedError {
    
    case failure(message: String?)
    case unknownMessage

    public var localization: String {
        switch self {
        case .failure(let message):
            if let msg = message {
                return msg
            }
            return ""
        case .unknownMessage:
            return ""
        }
    }
    
    static func  getError(err: Error) -> BaladError  {
        return .unknownMessage
    }
}
