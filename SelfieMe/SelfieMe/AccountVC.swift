//
//  AccountVC.swift
//  SelfieMe
//
//  Created by Thuong Vu on 7/29/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Thuong Vu"
        
        let revealController = self.revealViewController()
        addBackButton(self, target: revealController)
        addNextButton(self, target: self, action: "onClickNextButton", buttonImage: nil)
    }
    
    func onClickNextButton() {
        print("next button")
    }
}
