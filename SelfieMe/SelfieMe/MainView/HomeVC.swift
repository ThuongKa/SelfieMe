//
//  HomeVC.swift
//  SelfieMe
//
//  Created by Thuong Vu on 7/29/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let revealController = self.revealViewController()
        menuButton.addTarget(revealController, action: "revealToggle:", forControlEvents: .TouchUpInside)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    @IBAction func onClickCameraButton(sender: AnyObject) {
        let captureImageVC = UIStoryboard(name: "FunctionalView", bundle: nil).instantiateViewControllerWithIdentifier("CaptureImageVC") as! CaptureImageVC
        self.navigationController?.pushViewController(captureImageVC, animated: true)
    }
    
    @IBAction func onClickInboxButton(sender: AnyObject) {
    }
}
