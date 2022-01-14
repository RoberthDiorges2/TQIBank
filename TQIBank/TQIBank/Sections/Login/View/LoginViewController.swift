//
//  LoginViewController.swift
//  TQIBank
//
//  Created by Roberth Diorges on 11/01/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    // MARK: - Variables and Constants
    var viewModel: LoginViewModel!
    
    // MARK: - Initializers
    init(viewModel: LoginViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.isHidden = true
        viewModel.viewDelegate = self
    }
    
    // MARK: - IBActions
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        postAuthenticate()
    }
    
    // MARK: - Auxiliary Methods
    func postAuthenticate(showLoading: Bool = true) {
        guard let userName = userTextField.text, !userName.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else { return }
        isLoading(showLoading)
        viewModel.postAuthenticate(userName: userName, password: password)
    }
    
    func isLoading(_ loading: Bool) {
        indicatorView.isHidden = !loading
        loading ? indicatorView.startAnimating() : indicatorView.stopAnimating()
    }
}

// MARK: - LoginViewModelViewDelegate
extension LoginViewController: LoginViewModelViewDelegate {
    func loginViewModelShowLoading(_ viewModel: LoginViewModel, showLoading: Bool) {
        isLoading(showLoading)
    }
}
