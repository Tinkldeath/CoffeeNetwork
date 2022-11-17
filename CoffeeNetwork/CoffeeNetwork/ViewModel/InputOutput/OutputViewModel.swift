//
//  ClientErrorViewModel.swift
//  CoffeeNetwork
//
//  Created by Dima on 17.11.22.
//

import Foundation

struct OutputViewModel {
    struct RoleViewModel {
        var storyboardName: String
        var associatedViewController: String
    }
    
    struct SuccessfullyRegisteredViewModel {
        private var success: Bool
        
        init(success: Bool) {
            self.success = success
        }
        
        func isSuccess() -> Bool {
            return self.success == true
        }
    }
    
    struct ClientErrorViewModel {
        var clientDescription: String
    }
    
    struct CoffeeHouseViewModel {
        var id: String
        var name: String
    }
}
