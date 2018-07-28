//
//  RepublicanChatViewController.swift
//  meetUP
//
//  Created by Jeff Kim on 5/19/18.
//  Copyright © 2018 Jeff Kim. All rights reserved.
//

import UIKit
import Firebase

class RepublicanChatViewController: UIViewController {

    var messageArray: [Message] = [Message]()
    var accountNames: [String : String] = [:]
    var accountImages: [String: Data] = [:]
    
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    let userID = Auth.auth().currentUser!.uid
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        messageTextfield.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        messageTableView.register(UINib(nibName: "CustomMessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        retrieveMessages()
        messageTableView.separatorStyle = .none
        
        
    }
    
    @objc func tableViewTapped() {
        
        messageTextfield.endEditing(true)
    }

    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false
        sendButton.isEnabled = true
        
        let messagesDB = Database.database().reference().child("Messages2")
        let messagesDictionary = ["Sender": Auth.auth().currentUser?.email, "MessageBody": messageTextfield.text!]
        messagesDB.childByAutoId().setValue(messagesDictionary) {
            (error, ref) in
            
            if error != nil {
                print(error!)
            }
                
            else {
                print("Message Saved Successfully")
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                
                self.messageTextfield.text = ""
            }
        }
    }
    
    func retrieveMessages() {
        let messageDB = Database.database().reference().child("Messages2")
        messageDB.observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            let message = Message()
            message.sender = sender
            message.messageBody = text
            self.messageArray.append(message)
            self.messageTableView.reloadData()
            
        })
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func logOutUser(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
        }
            
        catch {
            print("There was an error while signing out.")
        }
        
        guard (navigationController?.popToRootViewController(animated: true)) != nil
            else {
                print("No view controllers to be popped off.")
                return
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
}

extension RepublicanChatViewController: UITableViewDelegate {
    
    
}

extension RepublicanChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = accountNames["\(messageArray[indexPath.row].sender)"]
        cell.avatarImageView.image = UIImage(data: accountImages["\(messageArray[indexPath.row].sender)"]!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
}

extension RepublicanChatViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
}


