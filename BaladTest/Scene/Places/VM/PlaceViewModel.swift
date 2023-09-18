//
//  PlaceViewModel.swift
//  BaladTest
//
//  Created by Ashkan Ghaderi on 2022-02-04.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class PlaceViewModel: ViewModelType {
    
    private let navigator: PlaceNavigator
    private let useCase: Domain.PlaceUseCase
    
    init( navigator: PlaceNavigator, useCase: Domain.PlaceUseCase) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let places = Driver.combineLatest(input.latitude,input.longitude).flatMapLatest {
            param in
            return self.useCase.fetchPlaces(lat: param.0, lng: param.1)
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { $0.map { PlaceModel($0) } }
        }
        
        let selectedPlace = input.selectionTrigger
            .withLatestFrom(places) { (indexPath, items) -> PlaceModel in
                return items[indexPath.row]
            }.do(onNext: navigator.toPlaceDetail)
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
                
                return Output(places: places, selectedPlace: selectedPlace, error: errors, isFetching: fetching)
                }
}

extension PlaceViewModel {
    struct Input {
        
        let latitude: Driver<Double>
        let longitude: Driver<Double>
        let selectionTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let places : Driver<[PlaceModel]>
        let selectedPlace: Driver<PlaceModel>
        let error: Driver<Error>
        let isFetching: Driver<Bool>
        
    }
    
}

