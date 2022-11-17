//
//  SignInViewController.swift
//  CoffeeNetwork
//
//  Created by Dima on 16.11.22.
//

import UIKit

protocol SignUpViewProtocol: AnyObject {
    func displaySuccess()
    func displayError(_ error: OutputViewModel.ClientErrorViewModel)
}

protocol SignInViewProtocol: AnyObject {
    func displaySignUpView(_ viewControllerName: String)
    func displayRoleView(_ roleViewModel: OutputViewModel.RoleViewModel)
    func displayError(_ error: OutputViewModel.ClientErrorViewModel)
}

class SignInViewController: UIViewController {
    
    @IBOutlet weak var signInOption: UISegmentedControl?
    @IBOutlet weak var login: UITextField?
    @IBOutlet weak var password: UITextField?
    
    private var viewModel: SignInViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SignInViewModel(view: self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        self.viewModel.signupAction(self.signInOption?.selectedSegmentIndex)
    }
    
    
    @IBAction func loginClicked(_ sender: Any) {
        guard let login = self.login?.text else { return }
        guard let password = self.password?.text else { return }
        let input = InputViewModel.InputLogin(login: login, password: password)
        Task { [weak self] in
           await self?.viewModel.signInAction(input)
        }
    }
    
}

extension SignInViewController: SignInViewProtocol {
    
    func displaySignUpView(_ viewControllerName: String) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: viewControllerName) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func displayError(_ error: OutputViewModel.ClientErrorViewModel) {
        Task {
            let ac = UIAlertController(title: "Error", message: error.clientDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func displayRoleView(_ roleViewModel: OutputViewModel.RoleViewModel){
        Task {
            let storyboard = UIStoryboard(name: roleViewModel.storyboardName, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: roleViewModel.associatedViewController)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
