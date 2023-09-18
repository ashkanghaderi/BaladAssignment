

import Foundation
import Domain
import Data
import UIKit

final class Application {
    static let shared = Application()
    
    private let networkUseCaseProvider: Domain.UseCaseProvider
    private init() {
        
        self.networkUseCaseProvider = UseCaseProvider()
    }
    
    func configureMainInterface(_ window: UIWindow){
        let mainNavigationController = MainNavigationController()
        window.rootViewController = mainNavigationController
        window.makeKeyAndVisible()
        
        PlaceNavigator(navigationController: mainNavigationController, services: networkUseCaseProvider).setup()
        
    }
}
