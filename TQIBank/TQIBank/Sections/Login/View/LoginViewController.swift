//
//  LoginViewController.swift
//  TQIBank
//
//  Created by Roberth Diorges on 11/01/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        
    }
}
