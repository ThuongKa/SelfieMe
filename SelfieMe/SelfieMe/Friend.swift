//
//  UserInfo.swift
//  SelfieMe
//
//  Created by Thuong Vu on 7/30/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import Foundation

class Friend: NSObject {
    
    ///
    var userID: String
    
    ///
    var username: String

    ///
    var gender: String
    
    ///
    var address: String
    
    ///
    var email: String
    
    ///
    var userImage: UIImage
    
    
    init (id: String, name: String, gender: String, address: String, email: String, image: UIImage?) {
        self.userID = id
        self.username = name
        self.gender = gender
        self.address = address
        self.email = email
        if let userImage = image {
            self.userImage = userImage
        } else {
            self.userImage = UIImage(named: "avatar")!
        }
    }
}