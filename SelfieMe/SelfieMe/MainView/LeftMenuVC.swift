//
//  LeftMenuVC.swift
//  SelfieMe
//
//  Created by Thuong Vu on 7/29/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import UIKit

class LefMenuVC: UITableViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    var functionStoryboard = UIStoryboard(name: "FunctionalView", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let revealController = self.revealViewController()
        var newFrontNav: UINavigationController!
        var newFrontVC: UIViewController!
        let cell = tableView.cellForRowAtIndexPath(indexPath)

        
        if indexPath.row == 0 {
            newFrontVC = functionStoryboard.instantiateViewControllerWithIdentifier("AccountVC") as! AccountVC

        } else if indexPath.row == 1 {
            newFrontVC = functionStoryboard.instantiateViewControllerWithIdentifier("MyCollectionVC") as! MyCollectionVC
        } else if indexPath.row == 2 {
            newFrontVC = functionStoryboard.instantiateViewControllerWithIdentifier("SelfieMeVC") as! SelfieMeVC
        } else if indexPath.row == 3 {
            newFrontVC = functionStoryboard.instantiateViewControllerWithIdentifier("InboxVC") as! InboxVC
        } else if indexPath.row == 4 {
            newFrontVC = functionStoryboard.instantiateViewControllerWithIdentifier("InviteFriendVC") as! InviteFriendVC
        }
        
        newFrontNav = BaseNavigationController(rootViewController: newFrontVC)
        revealController.setFrontViewController(newFrontNav, animated: true)
        revealController.pushFrontViewController(newFrontNav, animated: true)
    
        cell?.setSelected(false, animated: true)
    }
}
