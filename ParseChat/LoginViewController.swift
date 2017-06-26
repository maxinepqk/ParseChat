//
//  ViewController.swift
//  ParseChat
//
//  Created by Maxine Kwan on 6/26/17.
//  Copyright © 2017 Maxine Kwan. All rights reserved.
//

import Parse
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    var alertController: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createEmptyAlert()
    }
    
    func createEmptyAlert() {
        alertController = UIAlertController(title: "Username or password not entered", message: "Please enter valid username or password", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel) {(action) in }
        alertController.addAction(OKAction)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUp(_ sender: Any) {
        if ((usernameLabel.text?.isEmpty)! || (passwordLabel.text?.isEmpty)!) {
            present(alertController, animated: true)
        }
        else {
            let newUser = PFUser()
            newUser.username = usernameLabel.text
            newUser.password = passwordLabel.text
            
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    //, let code = PFErrorCode(rawValue: error._code) {code}
                    print(error.localizedDescription)
                } else {
                    print("User Registered successfully")
                }
            }
        }
    }
    
    @IBAction func login(_ sender: Any) {
        if ((usernameLabel.text?.isEmpty)! || (passwordLabel.text?.isEmpty)!) {
            present(alertController, animated: true)
        }
        else {
            let username = usernameLabel.text ?? ""
            let password = passwordLabel.text ?? ""
            PFUser.logInWithUsername(inBackground: username, password: password) {
                (user: PFUser?, error: Error?) in
                if let error = error {
                    print("User log in failed: \(error.localizedDescription)")
                } else {
                    
                    print("User logged in successfully")
                }
            }
        }
        
        
        
}
}
