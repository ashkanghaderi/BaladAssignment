//
//  PlaceDetailNavigatore.swift
//  BaladTest
//
//  Created by Ashkan Ghaderi on 2022-02-04.
//

import Foundation
import Domain
import UIKit

class PlaceDetailNavigator {
    
    private let navigationController: UINavigationController
    private let services: UseCaseProvider
    
    init(navigationController: UINavigationController, services: UseCaseProvider) {
        self.navigationController = navigationController
        self.services = services
    }
    
    func setup(placeModel: PlaceModel) {
        let placeDetailVC = PlaceDetailViewController(nibName: "PlaceDetailViewController", bundle: nil)
        placeDetailVC.viewModel = PlaceDetailViewModel(navigator: self, model: placeModel)
        navigationController.pushViewController(placeDetailVC, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
    
}
