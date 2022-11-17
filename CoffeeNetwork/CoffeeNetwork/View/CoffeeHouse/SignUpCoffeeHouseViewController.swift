//
//  SignUpCoffeeHouseViewController.swift
//  CoffeeNetwork
//
//  Created by Dima on 17.11.22.
//

import UIKit

class SignUpCoffeeHouseViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField?
    @IBOutlet weak var login: UITextField?
    @IBOutlet weak var password: UITextField?
    
    private var viewModel: SignUpViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SignUpViewModel(view: self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        guard let name = self.name?.text else { return }
        guard let login = self.login?.text else { return }
        guard let password = self.password?.text else { return }
        let input = InputSignUpCoffeeHouseViewModel(name: name, login: login, password: password)
        Task { [weak self] in
            await self?.viewModel.signUpAction(input)
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func presentAlert(_ title: String, _ description: String) {
        let ac = UIAlertController(title: title, message: description, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
}

extension SignUpCoffeeHouseViewController: SignUpViewProtocol {
    
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
