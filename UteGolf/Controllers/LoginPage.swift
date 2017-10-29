//
//  LoginPage.swift
//  UteGolf
//
//  Created by Keanu Interone on 10/23/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import UIKit

class LoginPage: UIViewController {

    var uteGolfLabel = UILabel()
    var usernameFeild = UITextField()
    var passwordFeild = UITextField()
    var loginButton = UIButton()
    var signupButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = UIColor.white
        
        uteGolfLabel.text = "Ute Golf"
        uteGolfLabel.font = UIFont.boldSystemFont(ofSize: view.frame.height / 7)
        uteGolfLabel.textAlignment = .center
        view.addSubview(uteGolfLabel)
        
        usernameFeild.placeholder = "Username"
        usernameFeild.layer.cornerRadius = 8
        usernameFeild.clipsToBounds = true
        usernameFeild.backgroundColor = UIColor.lightGray
        usernameFeild.autocapitalizationType = .none;
        usernameFeild.font = UIFont.systemFont(ofSize: 30)
        view.addSubview(usernameFeild)
        
        passwordFeild.placeholder = "Password"
        passwordFeild.layer.cornerRadius = 8
        passwordFeild.clipsToBounds = true
        passwordFeild.backgroundColor = UIColor.lightGray
        passwordFeild.autocapitalizationType = .none;
        passwordFeild.font = UIFont.systemFont(ofSize: 30)
        view.addSubview(passwordFeild)
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.layer.cornerRadius = 8
        loginButton.clipsToBounds = true
        loginButton.backgroundColor = UIColor.red
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        view.addSubview(loginButton)
        
        signupButton.setTitle("sign up", for: .normal)
        signupButton.layer.cornerRadius = 8
        signupButton.clipsToBounds = true
        signupButton.backgroundColor = UIColor.red
        view.addSubview(signupButton)
        
    }
    
    override func viewDidLayoutSubviews() {
        let padding = CGFloat(10)
        //let height = view.frame.height
        let width = view.frame.width
        
        uteGolfLabel.frame = CGRect(x: 0, y: 4*padding, width: width, height: uteGolfLabel.font.pointSize)
        
        usernameFeild.frame = CGRect(x: padding, y: uteGolfLabel.frame.maxY + 5*padding, width: width - 2*padding, height: 40)
        
        passwordFeild.frame = CGRect(x: padding, y: usernameFeild.frame.maxY + padding, width: width - 2*padding, height: 40)
        
        loginButton.frame = CGRect(x: padding, y: passwordFeild.frame.maxY + 2*padding, width: width - 2*padding, height: 60)
        
        signupButton.frame = CGRect(x: padding, y: loginButton.frame.maxY + padding, width: width - 2*padding, height: 30)
    }
    
    @objc func loginButtonClicked(sender: UIButton!) {

        loginButton.isEnabled = false;
        let username = usernameFeild.text!
        let password = passwordFeild.text!
        
        User.Login(Username: username, Password: password) { (user, message)  in
            
            if let loginUser = user {
                print(loginUser.FirstName + " " + loginUser.LastName + " " + loginUser.Login)
                AppState.state.user = user
                AppState.state.nav = UINavigationController(rootViewController: ProfilePage())
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
