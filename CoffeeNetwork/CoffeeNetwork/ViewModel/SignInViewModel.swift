//
//  SignInViewModel.swift
//  CoffeeNetwork
//
//  Created by Dima on 17.11.22.
//

import Foundation
import UIKit

protocol SignInViewModelProtocol {
    func signupAction(_ segmentSelection: Int?)
    func signInAction(_ input: InputViewModel.InputLogin) async
}

struct SignInViewModel: SignInViewModelProtocol {
    
    private weak var gatewayProvider: GatewayProviderProtocol?
    private weak var view: SignInViewProtocol?
    
    init(view: SignInViewProtocol?) {
        self.view = view
        self.gatewayProvider = UIApplication.shared.delegate as? AppDelegate
    }
    
    private var options: [Int: String] = [
        0: "SignUpCoffeHouseViewController",
        1: "SignUpEmployeeViewController",
        2: "SignUpClientViewController"
    ]
    
    func signupAction(_ segmentSelection: Int?) {
        guard let option = segmentSelection else { return }
        guard let viewControllerName = self.options[option] else { return }
        view?.displaySignUpView(viewControllerName)
    }
    
    func signInAction(_ input: InputViewModel.InputLogin) async {
        await self.gatewayProvider?.authorizationGateway.tryLogin(input, { viewModel, error in
            if let roleViewModel = viewModel {
                print("Logged in")
//                self.view?.displayRoleView(roleViewModel)
            }
            if let error = error {
                self.view?.displayError(error)
            }
        })
    }

}
