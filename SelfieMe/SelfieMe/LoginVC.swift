//
//  ViewController.swift
//  SelfieMe
//
//  Created by Thuong Vu on 7/28/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    var delegate: LoginDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onClickLoginFacebookButton(sender: AnyObject) {
        delegate?.didLoggingWitResult(true)
    }

    @IBAction func onClickLoginTwitterButton(sender: AnyObject) {
        delegate?.didLoggingWitResult(true)
    }
}


protocol LoginDelegate {
    func didLoggingWitResult(result: Bool)
}
