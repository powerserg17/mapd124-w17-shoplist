//
//  ViewController.swift
//  ShopList
//
//  Created by Serhii Pianykh on 2017-02-21.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "CartVC", sender: nil)
            }
        }
        
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        if !emailField.text!.isEmpty && !passwordField.text!.isEmpty {
            
                FIRAuth.auth()!.createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
                    if error == nil {
                        self.login(email: self.emailField.text!, password: self.passwordField.text!)
                    } else {
                        self.login(email: self.emailField.text!, password: self.passwordField.text!)
                    }
                }
            
           
        } else {
            showAlert(alertTitle: "Error!", alertMessage: "You have left empty fields!")
        }

    }
    
    //login to FB with email and pass
    func login(email: String, password: String) {
        FIRAuth.auth()!.signIn(withEmail: email,
                               password: password) {user, error in
                                if error != nil {
                                    self.showAlert(alertTitle: "Error!", alertMessage: "Invalid Credentials!")
                                }
        }
    }
    
    //func for showing alert with passed title and message
    func showAlert(alertTitle: String, alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okButton)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //clear textfields
    func clearFields() {
        self.emailField.text = ""
        self.passwordField.text = ""
    }


}

