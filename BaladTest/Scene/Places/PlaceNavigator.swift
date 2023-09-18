//
//  PlaceNavigator.swift
//  BaladTest
//
//  Created by Ashkan Ghaderi on 2022-02-04.
//

import Foundation
import Domain
import UIKit

class PlaceNavigator {
    
    private let navigationController: UINavigationController
    private let services: UseCaseProvider
    
    init(navigationController: UINavigationController, services: UseCaseProvider) {
        self.navigationController = navigationController
        self.services = services
    }
    
    func setup() {
        let placeVC = PlaceViewController(nibName: "PlaceViewController", bundle: nil)
        placeVC.viewModel = PlaceViewModel(navigator: self, useCase: services.makePlaceUseCase())
        navigationController.viewControllers = [placeVC]
    }
    
    func toPlaceDetail(model: PlaceModel) {
        
        PlaceDetailNavigator(navigationController: navigationController, services: services).setup(placeModel: model)
    }
    
}
