//
//  GatewayProtocols.swift
//  CoffeeNetwork
//
//  Created by Dima on 17.11.22.
//

import Foundation

typealias LoginCompletionHandler = (_ viewModel: OutputViewModel.RoleViewModel?, _ error: OutputViewModel.ClientErrorViewModel?) -> Void
typealias SignUpCompletionHandler = (_ success: OutputViewModel.SuccessfullyRegisteredViewModel?, _ error: OutputViewModel.ClientErrorViewModel?) -> Void
typealias FetchCoffeeHousesCompletionHandler = (_ data: [OutputViewModel.CoffeeHouseViewModel]?, _ error: OutputViewModel.ClientErrorViewModel?) -> Void


// MARK: - Sub-gateway protocols
protocol AuthorizationGatewayProtocol {
    func tryLogin(_ input: InputViewModel.InputLogin, _ completionHandler: @escaping LoginCompletionHandler) async
    func trySignUp(_ input: InputSignUpViewModelProtocol, _ completionHandler: @escaping SignUpCompletionHandler) async
}

protocol CoffeeHousesGatewayProtocol {
    func fetchCoffeeHouses(_ completionHandler: @escaping FetchCoffeeHousesCompletionHandler) async
}
