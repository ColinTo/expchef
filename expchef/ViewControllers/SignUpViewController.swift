//
//  SignUpViewController.swift
//  expchef
//
//  Created by Colin To on 2022-03-11.
//

import UIKit
import FirebaseAuth
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
            
            // Create user
            Auth.auth().createUser(withEmail: "", password: "") { (result, err) in
                
                // Check for errors
                if err != nil {
                    // There was an error creating the user
                    self.showError("Error creating user")
                    self.errorLabel.textColor = UIColor.red
                }
                else{
                    // User was created successfully, now store the first name and last name
//                    let db = Firestore.firestore()
                }
            }
        }
        
        // Transition to home screen
        
    }
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.alpha = 0
        // Do any additional setup after loading the view.
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
