//
//  LoginViewController.swift
//  Gig
//
//  Created by Kevin Stewart on 1/21/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import UIKit

enum LoginType {
    case signUp
    case logIn
}

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    var gigController: GigController?
    var loginType = LoginType.signUp
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Outlets
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var segmentedLogInButton: UISegmentedControl!
    @IBOutlet var segmentedSignUpButton: UISegmentedControl!
    
    // MARK: - Actions
    @IBAction func segmentedTypeChanged(_ sender: UISegmentedControl) {
        // switch UI between login types
        if sender.selectedSegmentIndex == 0 {
            loginType = .logIn
            logInButton.setTitle("Log In", for: .normal)
            
        } else {
            loginType = .signUp
            logInButton.setTitle("Sign Up", for: .normal)
        }
    }
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        guard let gigController = gigController else { return }
        guard let username = usernameTextField.text,
            !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty else { return }
        
        let user = User(username: username, password: password)
        
        if loginType == .signUp {
            gigController.signUp(with: user) { error in
                if let error = error {
                    print("Error occured during sign up: \(error)")
                } else {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Sign up successful", message: "Now please sign in", preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alertController.addAction(alertAction)
                        self.present(alertController, animated: true) {
                            self.loginType = .signUp
                            self.segmentedLogInButton.selectedSegmentIndex = 1
                            self.logInButton.setTitle("Sign In", for: .normal)
                        }
                    }
                }
            }
        } else {
        gigController.signUp(with: user) { error in
        if let error = error {
            print("Error occured during sign in: \(error)")
        } else {
        DispatchQueue.main.async {
        self.dismiss(animated: true, completion: nil)
        }
        }
        }
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
