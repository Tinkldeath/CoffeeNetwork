//
//  SignUpViewModel.swift
//  CoffeeNetwork
//
//  Created by Dima on 17.11.22.
//

import Foundation
import UIKit

protocol SignUpViewModelProtocol {
    func signUpAction(_ input: InputSignUpViewModelProtocol) async
}

struct SignUpViewModel: SignUpViewModelProtocol {
    
    private weak var gatewayProvider: GatewayProviderProtocol?
    private weak var view: SignUpViewProtocol?
    
    init(view: SignUpViewProtocol?) {
        self.view = view
        self.gatewayProvider = UIApplication.shared.delegate as? AppDelegate
    }
    
    func signUpAction(_ input: InputSignUpViewModelProtocol) async {
        await self.gatewayProvider?.authorizationGateway.trySignUp( input, { success, error in
            if let _ = success {
                self.view?.displaySuccess()
            }
            if let error = error {
                self.view?.displayError(error)
            }
        })
    }
    
}
