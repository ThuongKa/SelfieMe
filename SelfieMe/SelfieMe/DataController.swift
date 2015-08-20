//
//  DataController.swift
//  SelfieMe
//
//  Created by Thuong Vu on 7/30/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import Foundation

class DataController {
    
    class func getFriendList() -> [Friend] {
        
        var friends = Array<Friend>()
        
        let friend1 = Friend(id: "01", name: "Thuong Vu Huu", gender: "Male", address: "Ha Noi", email: "vuhuuthuong@gmail.com", image: nil)
        friends.append(friend1)
        let friend2 = Friend(id: "02", name: "Obama Ju", gender: "Male", address: "Ha Noi", email: "obama@ju.com", image: nil)
        friends.append(friend2)
        let friend3 = Friend(id: "03", name: "Chau Tinh Tri", gender: "Male", address: "China", email: "thanhtinh@cn.com", image: nil)
        friends.append(friend3)
        let friend4 = Friend(id: "04", name: "John Cater", gender: "Male", address: "USA", email: "john@us.com", image: nil)
        friends.append(friend4)
        let friend5 = Friend(id: "05", name: "Angeli Joe", gender: "Female", address: "UK", email: "joe@uk.com", image: nil)
        friends.append(friend5)
        let friend6 = Friend(id: "06", name: "Janie Beast", gender: "Switch", address: "Jungle", email: "Janie@switch.com", image: nil)
        friends.append(friend6)
        let friend7 = Friend(id: "07", name: "Bum Bum", gender: "Female", address: "Bum", email: "bumbum@gmail.com", image: nil)
        friends.append(friend7)
        let friend8 = Friend(id: "08", name: "Mr.Nor", gender: "Male", address: "Ha Noi", email: "mr.nor@gmail.com", image: nil)
        friends.append(friend8)
        let friend9 = Friend(id: "09", name: "Jack Chan", gender: "Male", address: "China", email: "jack.chan@gmail.com", image: nil)
        friends.append(friend9)
        let friend10 = Friend(id: "10", name: "Jay Choy", gender: "Male", address: "China", email: "jay@gmail.com", image: nil)
        friends.append(friend10)
        let friend11 = Friend(id: "11", name: "Putin", gender: "Male", address: "Russia", email: "pu.tin@rs.com", image: nil)
        friends.append(friend11)
        
        return friends
    }
}