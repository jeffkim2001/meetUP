//
//  ProfileSetupViewController.swift
//  meetUP
//
//  Created by Jeff Kim on 5/19/18.
//  Copyright © 2018 Jeff Kim. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase
import SVProgressHUD

class ProfileSetupViewController: UIViewController {


    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    let textField1 = SkyFloatingLabelTextField(frame: CGRect(x: 70, y: 350, width: 250, height: 45))
    let userID = Auth.auth().currentUser!.uid
    let userEmail = Auth.auth().currentUser!.email
    let imagePicker = UIImagePickerController()
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    var response : String = ""
    var accountResponses: [String: String] = [:]
    var accountNames: [String : String] = [:]
    var accountImages: [String : Data] = [:]
    
    override func viewWillAppear(_ animated: Bool) {
        if let theAccountNames = userDefaults.value(forKey: "accountNames") {
            accountNames = theAccountNames as! [String : String]
        }
        if let theAccountImages = userDefaults.value(forKey: "accountImages") {
            accountImages = theAccountImages as! [String : Data]
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.image = UIImage(named: "profile_default")
        doneButton.layer.borderWidth = 3.0
        doneButton.layer.borderColor = UIColor.blue.cgColor
        doneButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        navigationItem.title = "Profile Setup"
        textField1.placeholder = "Username"
        textField1.title = "Username"
        self.view.addSubview(textField1)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        doneButton.layer.cornerRadius = doneButton.frame.height/2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedDone(_ sender: Any) {
        
        accountNames["\(userEmail!)"] = textField1.text
        let image = profileImage.image
        let imageData = UIImageJPEGRepresentation(image!, 0.01) as NSData?
        accountImages["\(userEmail!)"] = imageData as! Data
        
        let rootVC = navigationController?.viewControllers.first as? WelcomeViewController
        rootVC?.accountImages = accountImages
        rootVC?.accountNames = accountNames
        rootVC?.accountResponses = accountResponses
        rootVC?.response = response
        navigationController?.popToRootViewController(animated: true)
        userDefaults.set(accountNames, forKey: "accountNames")
        userDefaults.set(accountImages, forKey: "accountImages")
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .camera
        self.imagePicker.allowsEditing = false
        self.imagePicker.navigationBar.barTintColor = UIColor(red: 67/255, green: 121/255, blue: 56/255, alpha: 1)
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func photoAlbumButtonPressed(_ sender: Any) {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = false
        self.imagePicker.navigationBar.barTintColor = UIColor(red: 67/255, green: 121/255, blue: 56/255, alpha: 1)
        self.imagePicker.navigationBar.isTranslucent = false
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension ProfileSetupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.image = image
            imagePicker.dismiss(animated: true, completion: nil)
        }
        SVProgressHUD.dismiss()
    }
}
