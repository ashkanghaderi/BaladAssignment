
import Foundation
import Resolver
import Domain

extension Resolver{
    
    public static func  ServiceInjection(){
        register(PlaceService.self)          {PlaceService(network: Network(BaseURL.dev.rawValue))}
        register(DefaultPlaceQueries.self)             {DefaultPlaceQueries()}
    }
    
}

