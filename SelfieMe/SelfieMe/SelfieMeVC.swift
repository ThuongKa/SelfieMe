//
//  SelfieMeVC.swift
//  SelfieMe
//
//  Created by Thuong Vu on 7/29/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import UIKit

class SelfieMeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Selfie with me"
        
        let revealController = self.revealViewController()
        addBackButton(self, target: revealController)
    }
    
}
