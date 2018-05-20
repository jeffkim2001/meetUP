//
//  CustomMessageCell.swift
//  meetUP
//
//  Created by Jeff Kim on 5/19/18.
//  Copyright © 2018 Jeff Kim. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {
    
    
    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var senderUsername: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBackground.layer.cornerRadius = messageBackground.frame.height/2
        messageBackground.layer.borderColor = UIColor.black.cgColor
        messageBackground.layer.borderWidth = 1.5
        
    }
    
}
