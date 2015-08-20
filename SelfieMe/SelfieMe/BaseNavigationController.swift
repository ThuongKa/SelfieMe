//
//  BaseNavigationController.swift
//  SelfieMe
//
//  Created by Thuong Vu on 8/5/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        self.navigationBar.translucent = false
        self.navigationBar.shadowImage = UIImage(named: "nav_pixel")
        self.navigationBar.setBackgroundImage(UIImage(named: "nav_pixel"), forBarMetrics: UIBarMetrics.Default)
        let font = UIFont(name: "Helvetica-Bold", size: 17)
        if let font = font {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.whiteColor()]
        }
    }
    
}
