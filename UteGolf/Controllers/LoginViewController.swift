//
//  LoginViewController.swift
//  UteGolf
//
//  Created by Keanu Interone on 10/28/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tap to dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        loginButton.layer.cornerRadius = 8
        loginButton.clipsToBounds = true
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
        loginButton.isEnabled = false;
        let username = usernameField.text!
        let password = passwordField.text!
        
        User.Login(Username: username, Password: password) { (user, message)  in
            
            if let loginUser = user {
                AppState.state.user = loginUser
                AppState.state.nav = UINavigationController(rootViewController: ProfileTabBarController())
                self.present(AppState.state.nav, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: {
                    self.loginButton.isEnabled = true;
                })
            }
        }
    }
    

    @IBAction func signUpButtonClicked(_ sender: Any) {
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
