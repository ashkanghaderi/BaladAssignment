//
//  AppDelegate.swift
//  BaladTest
//
//  Created by Ashkan Ghaderi on 2022-02-02.
//

import UIKit
import Pilgrim

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        PilgrimManager.shared().shouldDisableAdIdentitySharing = true
        PilgrimManager.shared().configure(withConsumerKey: "PQLZTEHJO3MWWKXCCL11LPVHWORNX1ZIYK1AK35NHYH11IHF", secret: "ENY31KTFMBX3OMI11HNV5Q2XFFVCNAAP5Y1KIDRIADJYQXQF", delegate: self, completion: nil)
        PilgrimManager.shared().start()
        
        setupApplication()

        return true
    }
    
    private func setupApplication() {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        Application.shared.configureMainInterface(window)
        self.window = window
    }

}

extension AppDelegate : PilgrimManagerDelegate {
  // Primary visit handler:
  func pilgrimManager(_ pilgrimManager: PilgrimManager, handle visit: Visit) {
    // Process the visit however you'd like:
    print("\(visit.hasDeparted ? "Departure from" : "Arrival at") \(visit.venue != nil ? visit.venue!.name : "Unknown venue."). Added a Pilgrim visit at: \(visit.displayName)")
  }

  // Optional: If visit occurred without network connectivity
  func pilgrimManager(_ pilgrimManager: PilgrimManager, handleBackfill visit: Pilgrim.Visit) {
    // Process the visit however you'd like:
    print("Backfill \(visit.hasDeparted ? "departure from" : "arrival at") \(visit.venue != nil ? visit.venue!.name : "Unknown venue."). Added a Pilgrim backfill visit at: \(visit.displayName)")
  }

  // Optional: If visit occurred by triggering a geofence
  func pilgrimManager(_ pilgrimManager: PilgrimManager, handle geofenceEvents: [GeofenceEvent]) {
    // Process the geofence events however you'd like. Here we loop through the potentially multiple geofence events and handle them individually:
    geofenceEvents.forEach { geofenceEvent in
      print(geofenceEvent)
    }
  }

  // Optional: If there is an update to the user state
  func pilgrimManager(_ pilgrimManager: PilgrimManager, handleUserState updatedUserState: UserState, changedComponents: UserStateComponent) {
    switch changedComponents {
    case .city:
        print("Welcome to \(String(describing: updatedUserState.city))")
      // handle other cases
    default:
        break
    }
  }

  // Optional: If there is an error
    func pilgrimManager(_ pilgrimManager: PilgrimManager, handle error: Error) {
      // handle any Pilgrim errors
      print(error)
    }
  }


