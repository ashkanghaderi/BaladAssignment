//
//  PlaceUseCase.swift
//  Data
//
//  Created by Ashkan Ghaderi on 2022-02-03.
//

import Foundation
import Domain
import RxSwift

public final class PlaceUseCase: Domain.PlaceUseCase {
    let bag = DisposeBag()
    @LazyInjected private var service: PlaceService
    @LazyInjected private var queries: DefaultPlaceQueries
    
    public init(){}
    
    public func fetchPlaces(lat:Double,lng:Double) -> Observable<[Place]> {
        if fetchPolicy.share.shouldFetchPlacesFromServer {
            fetchPolicy.share.shouldFetchPlacesFromServer = false
            let _: () = service.fetchAllPlaces(lat: lat, lng: lng).subscribe(onNext: { [weak self] (places) in
                
                for place in places {
                    self?.queries.save(primaryKey: place.fsqID!, with: place, completion: nil)
                }
                
            }, onError: { err in
                
            }).disposed(by: bag)
        }
        
        return Observable<[Place]>.create { observer in
            
            do {
                let values = try self.queries.fetchAllPlaces()
                observer.onNext(values)
                observer.onCompleted()
            } catch let err {
                observer.onError(BaladError.failure(message: err.localizedDescription))
            }
            
            return Disposables.create()
        }
    }
    
}
