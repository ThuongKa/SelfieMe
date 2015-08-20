//
//  ViewController.swift
//  SelfieMe
//
//  Created by Thuong Vu on 7/29/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func addBackButton(viewController: UIViewController, target buttonTarget: AnyObject?) {
        let backButton = UIButton(type: .Custom)
        backButton.frame = CGRectMake(0, 0, 32, 32)
        backButton.setBackgroundImage(UIImage(named: "back"), forState: .Normal)
        backButton.addTarget(buttonTarget, action: "revealToggle:", forControlEvents: .TouchUpInside)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func addNextButton(viewController: UIViewController, target buttonTarget: AnyObject?, action: Selector, buttonImage: UIImage?) {
        let nextButton = UIButton(type: .Custom)
        nextButton.frame = CGRectMake(0, 0, 32, 32)
        if buttonImage != nil {
            nextButton.setBackgroundImage(buttonImage, forState: .Normal)
        } else {
            nextButton.setBackgroundImage(UIImage(named: "next"), forState: .Normal)
        }
        nextButton.addTarget(buttonTarget, action: action, forControlEvents: .TouchUpInside)
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextButton)
    }
    
    
    func setBackButtonImage(viewController: UIViewController, image: UIImage, action: Selector) {
        let backButton = UIButton(type: .Custom)
        backButton.frame = CGRectMake(0, 0, 32, 32)
        backButton.setBackgroundImage(UIImage(named: "back"), forState: .Normal)
        backButton.addTarget(viewController, action: action, forControlEvents: .TouchUpInside)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
}