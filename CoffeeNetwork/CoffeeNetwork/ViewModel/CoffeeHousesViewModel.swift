//
//  CoffeeHousesViewModel.swift
//  CoffeeNetwork
//
//  Created by Dima on 17.11.22.
//

import Foundation
import UIKit

protocol CoffeeHousesViewModelProtocol {
    func presentCoffeeHousesAction() async
    func didSelectCoffeeHouseAction(_ coffeHouse: OutputViewModel.CoffeeHouseViewModel)
}

struct CoffeeHousesViewModel: CoffeeHousesViewModelProtocol {
    
    private weak var gatewayProvider: GatewayProviderProtocol?
    private weak var view: CoffeeHousesViewProtocol?
    
    init(view: CoffeeHousesViewProtocol?) {
        self.view = view
        self.gatewayProvider = UIApplication.shared.delegate as? AppDelegate
    }
    
    func presentCoffeeHousesAction() async {
        await self.gatewayProvider?.coffeeHousesGateway.fetchCoffeeHouses({ data, error in
            if let data = data {
                self.view?.displayCoffeeHouses(data)
            }
            if let error = error {
                self.view?.displayError(error)
            }
        })
    }
    
    func didSelectCoffeeHouseAction(_ coffeHouse: OutputViewModel.CoffeeHouseViewModel) {
        self.view?.displayCoffeeHouse(coffeHouse)
    }
    
}
