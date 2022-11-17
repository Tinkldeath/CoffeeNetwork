//
//  RealmGateway.swift
//  CoffeeNetwork
//
//  Created by Dima on 17.11.22.
//

import Foundation
import RealmSwift

final class RealmGateway{
    
    private var app: App
    private var appId = "coffeenetwork-okoyc"
    
    init() {
        self.app = App(id: self.appId)
    }
    
}

extension RealmGateway: AuthorizationGatewayProtocol {
    func tryLogin(_ input: InputViewModel.InputLogin, _ completionHandler: @escaping LoginCompletionHandler) {
        let email = input.login
        let password = input.password
        self.app.login(credentials: Credentials.emailPassword(email: email, password: password)) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(nil, OutputViewModel.ClientErrorViewModel(clientDescription: error.localizedDescription))
            case .success(let user):
                print(self.app.currentUser?.id == user.id)
                // TODO: Generate view controller for user
            }
        }
    }
    
    func trySignUp(_ input: InputSignUpViewModelProtocol, _ completionHandler: @escaping SignUpCompletionHandler) async {
        let client = self.app.emailPasswordAuth
        let email = input.login
        let password = input.password
        do {
            try await client.registerUser(email: email, password: password)
            completionHandler(OutputViewModel.SuccessfullyRegisteredViewModel(success: true), nil)
        } catch {
            let error = OutputViewModel.ClientErrorViewModel(clientDescription: error.localizedDescription)
            completionHandler(nil, error)
        }
    }
}

extension RealmGateway: CoffeeHousesGatewayProtocol {
    func fetchCoffeeHouses(_ completionHandler: @escaping FetchCoffeeHousesCompletionHandler) {
        completionHandler([OutputViewModel.CoffeeHouseViewModel(id: "", name: "Example")], nil)
    }
}
