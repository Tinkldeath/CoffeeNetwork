//
//  InputViewModel.swift
//  CoffeeNetwork
//
//  Created by Dima on 17.11.22.
//

import Foundation

struct InputViewModel {
    struct InputLogin {
        var login: String
        var password: String
    }
}

protocol InputSignUpViewModelProtocol {
    var login: String { get }
    var password: String { get }
}

struct InputSignUpCoffeeHouseViewModel: InputSignUpViewModelProtocol {
    var name: String
    var login: String
    var password: String
}

struct InputSignUpClientViewModel: InputSignUpViewModelProtocol {
    var name: String
    var login: String
    var password: String
}

struct InputSignUpEmployeeViewModel: InputSignUpViewModelProtocol {
    var coffeeHouseId: String?
    var name: String
    var login: String
    var password: String
}
