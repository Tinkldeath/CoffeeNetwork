//
//  SignUpEmployeeViewController.swift
//  CoffeeNetwork
//
//  Created by Dima on 17.11.22.
//

import UIKit

protocol CoffeeHousesViewProtocol: AnyObject {
    func displayCoffeeHouses(_ houses: [OutputViewModel.CoffeeHouseViewModel])
    func displayCoffeeHouse(_ house: OutputViewModel.CoffeeHouseViewModel)
    func displayError(_ error: OutputViewModel.ClientErrorViewModel)
}

class SignUpEmployeeViewController: UIViewController {
    
    @IBOutlet weak var employerButton: UIButton?
    @IBOutlet weak var name: UITextField?
    @IBOutlet weak var login: UITextField?
    @IBOutlet weak var password: UITextField?
    
    
    private var viewModel: SignUpViewModelProtocol!
    private var coffeHousesViewModel: CoffeeHousesViewModelProtocol!
    private var selection: OutputViewModel.CoffeeHouseViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SignUpViewModel(view: self)
        self.coffeHousesViewModel = CoffeeHousesViewModel(view: self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func employerClicked(_ sender: Any) {
        Task { [weak self] in
            await self?.coffeHousesViewModel.presentCoffeeHousesAction()
        }
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        guard let name = self.name?.text else { return }
        guard let login = self.login?.text else { return }
        guard let password = self.password?.text else { return }
        let input = InputSignUpEmployeeViewModel(coffeeHouseId: self.selection?.id, name: name, login: login, password: password)
        Task { [weak self] in
            await self?.viewModel.signUpAction(input)
        }
    }
    
    func presentAlert(_ title: String, _ description: String) {
        let ac = UIAlertController(title: title, message: description, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
}

extension SignUpEmployeeViewController: SignUpViewProtocol {
    
    func displaySuccess() {
        Task { [weak self] in
            self?.presentAlert("Success", "Successfully registered")
        }
    }
    
    func displayError(_ error: OutputViewModel.ClientErrorViewModel) {
        Task { [weak self] in
            self?.presentAlert("Error", error.clientDescription)
        }
    }

}

extension SignUpEmployeeViewController: CoffeeHousesViewProtocol {
    
    func displayCoffeeHouses(_ houses: [OutputViewModel.CoffeeHouseViewModel]) {
        let ac = UIAlertController(title: "Select employer", message: nil, preferredStyle: .alert)
        for house in houses {
            ac.addAction(UIAlertAction(title: house.name, style: .default, handler: { [weak self] _ in
                self?.coffeHousesViewModel.didSelectCoffeeHouseAction(house)
            }))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func displayCoffeeHouse(_ house: OutputViewModel.CoffeeHouseViewModel) {
        self.employerButton?.setTitle(house.name, for: .normal)
    }
    
}
