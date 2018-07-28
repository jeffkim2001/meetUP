//
//  LogInViewController.swift
//  meetUP
//
//  Created by Jeff Kim on 5/19/18.
//  Copyright © 2018 Jeff Kim. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase
import SVProgressHUD


class LogInViewController: UIViewController {
    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    let textField1 = SkyFloatingLabelTextField(frame: CGRect(x: 70, y: 200, width: 250, height: 45))
    let textField2 = SkyFloatingLabelTextField(frame: CGRect(x: 70, y: 300, width: 250, height: 45))
    @IBOutlet weak var logInButton: UIButton!
    var accountResponses: [String: String] = [:]
    var accountNames: [String : String] = [:]
    var accountImages: [String: Data] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Log In"
        textField1.placeholder = "Email"
        textField1.title = "Email"
        self.view.addSubview(textField1)
        textField2.placeholder = "Password"
        textField2.title = "Password"
        self.view.addSubview(textField2)
        logInButton.layer.borderColor = UIColor.blue.cgColor
        logInButton.layer.borderWidth = 3.0
        logInButton.layer.cornerRadius = logInButton.layer.frame.height/2
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        textField2.isSecureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func logInUser(_ sender: Any) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: textField1.text!, password: textField2.text!, completion: { (user, error) in
            
            if error != nil {
                print(error!)
            }
                
            else {
                print("Log in was successful.")
                SVProgressHUD.dismiss()
                let userID = Auth.auth().currentUser!.uid
                self.performSegue(withIdentifier: "go\(self.accountResponses["\(userID)"]!)", sender: self)
            }
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goLibertarian" {
            let destinationVC = segue.destination as! LibertarianChatViewController
            destinationVC.accountNames = accountNames
            destinationVC.accountImages = accountImages
        }
        else if segue.identifier == "goGreen" {
            let destinationVC = segue.destination as! GreenChatViewController
            destinationVC.accountNames = accountNames
            destinationVC.accountImages = accountImages
        }
        else if segue.identifier == "goRepublican" {
            let destinationVC = segue.destination as! RepublicanChatViewController
            destinationVC.accountNames = accountNames
            destinationVC.accountImages = accountImages
        }
        else if segue.identifier == "goDemocratic" {
            let destinationVC = segue.destination as! DemocratChatViewController
            destinationVC.accountNames = accountNames
            destinationVC.accountImages = accountImages
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func goBack(_ sender: Any) {
        
        performSegue(withIdentifier: "goToWelcome2", sender: self)
        
    }
    
}
