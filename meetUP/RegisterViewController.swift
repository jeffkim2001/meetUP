//
//  RegisterViewController.swift
//  meetUP
//
//  Created by Jeff Kim on 5/19/18.
//  Copyright © 2018 Jeff Kim. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {
    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    let textField1 = SkyFloatingLabelTextField(frame: CGRect(x: 70, y: 200, width: 250, height: 45))
    let textField2 = SkyFloatingLabelTextField(frame: CGRect(x: 70, y: 300, width: 250, height: 45))
    @IBOutlet weak var registerButton: UIButton!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "Register"
        textField1.placeholder = "Email"
        textField1.title = "Email"
        self.view.addSubview(textField1)
        textField2.placeholder = "Password"
        textField2.title = "Password"
        self.view.addSubview(textField2)
        registerButton.layer.borderColor = UIColor.blue.cgColor
        registerButton.layer.borderWidth = 3.0
        registerButton.layer.cornerRadius = registerButton.layer.frame.height/2
        textField2.isSecureTextEntry = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func registerTheUser(_ sender: Any) {
        
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: textField1.text!, password: textField2.text!, completion: { (user, error) in
            if error != nil {
                print(error!)
            }
                
            else{
                print("Registration Successful!")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToQuestionnaire", sender: self)
            }
        }
            
        )
    
    }
    
    @IBAction func goBack(_ sender: Any) {
        
        performSegue(withIdentifier: "backToWelcome", sender: self)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    

}
