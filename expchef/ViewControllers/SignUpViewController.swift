//
//  SignUpViewController.swift
//  expchef
//
//  Created by Colin To on 2022-03-11.
//

import UIKit
//import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    // Check the fields and validate that the data is correct.
    // If everything is correct, this method returns nil.
    // Otherwise, it returns the error message
    
    func validateFields() -> String? {
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields."
        }
        
        // Check if password is secure
        
        return nil
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        
        // Validate fields
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        
        else{
            
            // Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    // There was an error creating the user
                    // err?.localizedDescription - can you use this to show explicit error to user
                    self.showError("Error creating user")
                    self.errorLabel.textColor = UIColor.red
                }
                else{
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    // Uid is from result after auth gets created at createUser
                    db.collection("users").addDocument(data: ["firstname":firstName,"lastname":lastName, "uid":result!.user.uid]) { (error) in
                        
                        // The user has been created. This failure would be for first and last name. Account would still be created though
                        if error != nil {
                            // Show error message
                            self.showError("Error saving first and last name data. Entry still created.")
                        }
                    }
                }
            }
        }
        
        // Transition to home screen
        self.transitionToHome()
        
    }
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
        
        let homeUITabViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeUITabViewController) as? UITabBarController
        
        self.view.window?.rootViewController = homeUITabViewController
        self.view.window?.makeKeyAndVisible()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.alpha = 0
        // Do any additional setup after loading the view.
    }

}
