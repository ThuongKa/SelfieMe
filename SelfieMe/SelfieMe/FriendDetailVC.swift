//
//  FriendDetailVC.swift
//  SelfieMe
//
//  Created by Thuong Vu on 8/4/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import UIKit

class FriendDetailVC: UIViewController {
    
    ///
    var friend: Friend!
    
    ///
    var collectionVC: FriendCollectionVC!
    
    ///
    var infoVC: FriendInfoVC!
    
    ///
    @IBOutlet weak var collectionView: UIView!
    
    ///
    @IBOutlet weak var moreView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.hidden = false
        moreView.hidden = true
        setBackButtonImage(self, image: UIImage(named: "back")!, action: "pop")
        self.title = friend.username
        collectionVC = UIStoryboard(name: "FunctionalView", bundle: nil).instantiateViewControllerWithIdentifier("FriendCollectionVC") as! FriendCollectionVC
        addChildView(collectionVC, toViewController: self, backView: collectionView)
        
    }
    
    func pop() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func addChildView(viewcontroller: UIViewController, toViewController desVC: UIViewController, backView: UIView) {
        viewcontroller.view.frame = CGRect(x: 0.0, y: 0.0, width: backView.frame.size.width, height: backView.frame.size.height)
        desVC.addChildViewController(viewcontroller)
        backView.addSubview(viewcontroller.view)
        viewcontroller.didMoveToParentViewController(desVC)
    }
    
    @IBAction func onClickCollectionButton(sender: AnyObject) {
        collectionView.hidden = false
        moreView.hidden = true
    }
    
    
    @IBAction func onClickMoreButton(sender: AnyObject) {
        if moreView.subviews.count == 0 {
            infoVC = UIStoryboard(name: "FunctionalView", bundle: nil).instantiateViewControllerWithIdentifier("FriendInfoVC") as! FriendInfoVC
            infoVC.friend = friend
            addChildView(infoVC, toViewController: self, backView: moreView)
            
        }
        collectionView.hidden = true
        moreView.hidden = false
    
    }
    
}
