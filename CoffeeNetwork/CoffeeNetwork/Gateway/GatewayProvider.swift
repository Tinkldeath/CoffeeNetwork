//
//  Gateway.swift
//  CoffeeNetwork
//
//  Created by Dima on 17.11.22.
//

import Foundation

protocol GatewayProviderProtocol: AnyObject {
    var authorizationGateway: AuthorizationGatewayProtocol { get }
    var coffeeHousesGateway: CoffeeHousesGatewayProtocol { get }
}
