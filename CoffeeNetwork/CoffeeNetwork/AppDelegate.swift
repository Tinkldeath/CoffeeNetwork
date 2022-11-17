//
//  AppDelegate.swift
//  CoffeeNetwork
//
//  Created by Dima on 16.11.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let gateway = RealmGateway()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: GatewayProviderProtocol {
    var authorizationGateway: AuthorizationGatewayProtocol {
        return self.gateway
    }
    var coffeeHousesGateway: CoffeeHousesGatewayProtocol {
        return self.gateway
    }
}
