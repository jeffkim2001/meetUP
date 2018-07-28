//
//  QuestionnaireViewController.swift
//  meetUP
//
//  Created by Jeff Kim on 5/19/18.
//  Copyright © 2018 Jeff Kim. All rights reserved.
//

import UIKit
import Firebase

class QuestionnaireViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    let userID = Auth.auth().currentUser!.uid
    var response: String = ""
    var accountResponses: [String: String] = [:]
    let userDefaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(QuestionnaireViewController.proceedUser))
        questionLabel.text = "Which best represents your political beliefs?"
        button1.layer.borderColor = UIColor.blue.cgColor
        button2.layer.borderColor = UIColor.blue.cgColor
        button3.layer.borderColor = UIColor.blue.cgColor
        button4.layer.borderColor = UIColor.blue.cgColor
        button1.layer.borderWidth = 3.0
        button2.layer.borderWidth = 3.0
        button3.layer.borderWidth = 3.0
        button4.layer.borderWidth = 3.0
        button1.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        button2.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        button3.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        button4.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button1.layer.cornerRadius = button1.frame.height/2
        button2.layer.cornerRadius = button2.frame.height/2
        button3.layer.cornerRadius = button3.frame.height/2
        button4.layer.cornerRadius = button4.frame.height/2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
        
    }
    
    @IBAction func responseSubmitted(_ sender: UIButton) {
        
        button1.layer.backgroundColor = UIColor.white.cgColor
        button2.layer.backgroundColor = UIColor.white.cgColor
        button3.layer.backgroundColor = UIColor.white.cgColor
        button4.layer.backgroundColor = UIColor.white.cgColor
        sender.layer.backgroundColor = UIColor.green.cgColor
        response = (sender.titleLabel?.text)!
        accountResponses["\(userID)"] = response
        userDefaults.set(accountResponses, forKey: "accountResponses")
        
    }
    
    @objc func proceedUser() {
        performSegue(withIdentifier: "setProfile", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "setProfile" {
            let destinationVC = segue.destination as! ProfileSetupViewController
            destinationVC.response = response
            destinationVC.accountResponses = accountResponses
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        if let theAccountResponses = userDefaults.value(forKey: "accountResponses") {
            accountResponses = theAccountResponses as! [String : String]
        }
    }
    
}

