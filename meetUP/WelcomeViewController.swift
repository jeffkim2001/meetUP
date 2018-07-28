//
//  WelcomeViewController.swift
//  meetUP
//  Created by Jeff Kim on 5/19/18.
//  Copyright © 2018 Jeff Kim. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    var response: String = ""
    var accountResponses: [String : String] = [:]
    var accountNames: [String : String] = [:]
    var accountImages: [String : Data] = [:]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        registerButton.layer.borderColor = UIColor.blue.cgColor
        registerButton.layer.borderWidth = 3.0
        registerButton.layer.cornerRadius = registerButton.frame.height/2
        logInButton.layer.borderColor = UIColor.blue.cgColor
        logInButton.layer.borderWidth = 3.0
        logInButton.layer.cornerRadius = logInButton.frame.height/2
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func registerTheUser(_ sender: Any) {
   
        performSegue(withIdentifier: "registerUser", sender: self)
    
    }
    
    
    @IBAction func logInTheUser(_ sender: Any) {
        
        performSegue(withIdentifier: "logInUser", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logInUser" {
            let destinationVC = segue.destination as! LogInViewController
            destinationVC.accountResponses = accountResponses
            destinationVC.accountNames = accountNames
            destinationVC.accountImages = accountImages
        }
    }
    

}

