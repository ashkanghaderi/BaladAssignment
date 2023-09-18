//
//  PlaceDetailViewModel.swift
//  BaladTest
//
//  Created by Ashkan Ghaderi on 2022-02-04.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class PlaceDetailViewModel: ViewModelType {
    
    private let navigator: PlaceDetailNavigator
    private let model: PlaceModel
    
    init( navigator: PlaceDetailNavigator, model: PlaceModel) {
        self.model = model
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        let selectedPlace = Driver.of(model)
        
        return Output(selectedPlace: selectedPlace, error: errors, isFetching: fetching)
    }
}

extension PlaceDetailViewModel {
    struct Input {
    }
    
    struct Output {
        let selectedPlace: Driver<PlaceModel>
        let error: Driver<Error>
        let isFetching: Driver<Bool>
    }
}

