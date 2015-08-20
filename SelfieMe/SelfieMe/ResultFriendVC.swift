//
//  ResultFriendVC.swift
//  SelfieMe
//
//  Created by Thuong Vu on 7/30/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import UIKit

class ResultFriendVC: UITableViewController {
    
    var resultFriends: Array<Friend>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(red: 15/256, green: 29/256, blue: 42/256, alpha: 1.0)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.registerNib(UINib(nibName: "SelfiemeCell", bundle: nil), forCellReuseIdentifier: "SelfiemeCell")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultFriends.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SelfiemeCell", forIndexPath: indexPath) as! SelfiemeCell
        
        let friend = resultFriends[indexPath.row]
        cell.bindingDataToCell(friend)
        
        return cell
    }
}
