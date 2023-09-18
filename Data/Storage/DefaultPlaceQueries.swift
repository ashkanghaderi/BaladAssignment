//
//  DefaultPlaceQueries.swift
//  Data
//
//  Created by Ashkan Ghaderi on 2022-02-03.
//

import Foundation
import Domain
import CoreStore

public final class DefaultPlaceQueries: PlaceQueriesProtocol {
    
    // MARK: - Data Stack
    lazy var dataStack: DataStack = {
        let ds = DataStack(
            CoreStoreSchema(
                modelVersion: "V1", entities:[
                    Entity<DefaultPlace>("Place")]
            ))
        try! ds.addStorageAndWait(
            SQLiteStore(
                fileName: "Places.xcdatamodeld",
                localStorageOptions: .recreateStoreOnModelMismatch
            ))
        return ds
    }()
    
    public func save(primaryKey: String, with place: Place, completion: VoidCompletion?) {
        
        guard Thread.isMainThread else {
            completion?(.failure(AppErrors.shouldBeRunOnMainThread))
            return
        }
        dataStack.perform(
            asynchronous: { transaction in
                let obj = transaction.create(Into<DefaultPlace>())
                obj.primaryKey = primaryKey
                obj.place = place
            },
            completion: {
                switch $0 {
                case .success: completion?(.success(()))
                case .failure(let err): completion?(.failure(err))
                }
            })
    }
    
    public func fetchAllPlaces() throws -> [Place] {
        
        let DefaultPlaceList = try dataStack.fetchAll(
            From<DefaultPlace>()
        )
        
        return DefaultPlaceList.map { $0.place }
    }
    
    
}
