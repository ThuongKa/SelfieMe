//
//  FriendInfo.swift
//  SelfieMe
//
//  Created by Thuong Vu on 8/4/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import UIKit

class FriendInfoVC: UITableViewController {
    
    var friend: Friend!
    
    @IBOutlet weak var userInfoLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingData(friend)
    }
    
    func bindingData(friend: Friend) {
        userInfoLabel.text = friend.userID
        usernameLabel.text = friend.username
        genderLabel.text = friend.gender
        addressLabel.text = friend.address
        emailLabel.text = friend.email
    }
    
    @IBAction func onClickLogoutButton(sender: AnyObject) {
        //
        print("Logout action")
    }
}