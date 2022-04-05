//
//  ViewController.swift
//  expchef
//
//  Created by Colin To on 2022-03-11.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBAction func loginPressed(_ sender: Any) {
        
        // Validate Text Field
        
        // Create cleaned version of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        // Sign User in
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
//                self.errorLabel.text = error!.localizedDescription
//                self.errorLabel.alpha = 1
            }
            else {
                // Because this returns a viewcontroller. We have to use "as" to typecast it to HomeViewController type
//                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
//
//                self.view.window?.rootViewController = homeViewController
//                self.view.window?.makeKeyAndVisible()
                let homeUITabViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeUITabViewController) as? UITabBarController
                
                self.view.window?.rootViewController = homeUITabViewController
                self.view.window?.makeKeyAndVisible()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginBtn.layer.cornerRadius = 25.0
    }


}

